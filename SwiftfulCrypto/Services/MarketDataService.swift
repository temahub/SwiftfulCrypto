//
//  MarketDataService.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 8/1/25.
//

import Foundation

import Foundation
import Combine

final class MarketDataService {
  @Published var marketData: MarketDataModel? = nil
//  var cancellables = Set<AnyCancellable>()
  var marketDataSubscription: AnyCancellable?
  
  init() {
    getmarketData()
  }
  
  func getmarketData() {
    guard let url = URL(string: "https://api.coingecko.com/api/v3/global")
    else { return }
    
    // TODO: Replace Combine to Structured Concurrency
    marketDataSubscription = NetworkingManager.download(url: url)
      .decode(type: GlobalData.self, decoder: JSONDecoder())
      .sink(receiveCompletion: NetworkingManager.handlingComplition,
            receiveValue: { [weak self] (returnedGlobalData) in
        self?.marketData = returnedGlobalData.data
        self?.marketDataSubscription?.cancel()
      })
//      .store(in: &cancellables)

  }
}
