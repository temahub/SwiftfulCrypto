//
//  CoinDataService.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 4/1/25.
//

import Foundation
import Combine

final class CoinDataService {
  @Published var allCoins: [CoinModel] = []
//  var cancellables = Set<AnyCancellable>()
  var coinSubscription: AnyCancellable?
  
  init() {
    getCoins()
  }
  
  func getCoins() {
    guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h")
    else { return }
    
    // TODO: Replace Combine to Structured Concurrency
    coinSubscription = NetworkingManager.download(url: url)
      .decode(type: [CoinModel].self, decoder: JSONDecoder())
      .sink(receiveCompletion: NetworkingManager.handlingComplition,
            receiveValue: { [weak self] (returnedCoins) in
        self?.allCoins = returnedCoins
        self?.coinSubscription?.cancel()
      })
//      .store(in: &cancellables)

  }
}
