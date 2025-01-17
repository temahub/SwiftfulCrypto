//
//  PortfolioDataService.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 10/1/25.
//

import Foundation
import CoreData

final class PortfolioDataService {
  private let PORTFOLIO_CONTAINER = "PortfolioContainer"
  private let ENTITY_NAME = "PortfolioEntity"
  
  private let container: NSPersistentContainer
  @Published var savedEntities: [PortfolioEntity] = []
  
  init() {
    self.container = NSPersistentContainer(name: PORTFOLIO_CONTAINER)
    container.loadPersistentStores { _, error in
      if let error = error {
        print("Error loading Core Data:\n\(error)")
      }
      self.getPortfolio()
    }
  }
  
  // MARK: PUBLIC
  
  func updatePortfolio(coin: CoinModel, amount: Double) {
    // check if coin is already in portfolio
    if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
      if amount > 0 {
        update(entity: entity, amount: amount )
      } else {
        remove(entity: entity)
      }
    } else {
      add(coin: coin, amount: amount)
    }
  }
  
  // MARK: PRIVATE
  private func getPortfolio() {
    let request = NSFetchRequest<PortfolioEntity>(entityName: ENTITY_NAME)
    do {
      savedEntities = try container.viewContext.fetch(request)
    } catch let error {
      print("Error fetching Portfolio entities:\n\(error)")
    }
  }
  
  private func add(coin: CoinModel, amount: Double) {
    let entity = PortfolioEntity(context: container.viewContext)
    entity.coinID = coin.id
    entity.amount = amount
    applyChanges()
  }
  
  private func update(entity: PortfolioEntity, amount: Double) {
    entity.amount = amount
    applyChanges()
  }
  
  private func remove(entity: PortfolioEntity) {
    container.viewContext.delete(entity)
    applyChanges()
  }
  
  private func save() {
    do {
      try container.viewContext.save()
    } catch let error {
      print("Error saving to Core Data:\n\(error)")
    }
  }
  
  private func applyChanges() {
    save()
    getPortfolio()
  }
}
