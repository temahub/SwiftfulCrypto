//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 3/1/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
  @Published var allCoins: [CoinModel] = []
  @Published var portfolioCoins: [CoinModel] = []
  @Published var searchText: String = ""
  
  private let dataService = CoinDataService()
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    addSubscribers()
  }
  
  func addSubscribers() {
    // TODO: Replace Combine to Structured Concurrency
//    dataService.$allCoins
//      .sink { [weak self] (returnedCoins) in
//        self?.allCoins = returnedCoins
//      }
//      .store(in: &cancellables)
    
    // updates allCoins
    $searchText
      .combineLatest(dataService.$allCoins)
      .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
      .map(filterCoins)
      .sink { [weak self] (returnedCoins) in
        self?.allCoins = returnedCoins
      }
      .store(in: &cancellables)
  }
  
  private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
    guard !text.isEmpty else {
      return coins
    }
    
    let lowercasedText  = text.lowercased()
    return coins.filter { (coin) in
      return coin.name.lowercased().contains(lowercasedText) ||
      coin.symbol.lowercased().contains(lowercasedText) ||
      coin.id.lowercased().contains(lowercasedText)
    }
  }
}
