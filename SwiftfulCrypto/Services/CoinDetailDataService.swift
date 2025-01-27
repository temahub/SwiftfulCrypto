//
//  CoinDetailDataService.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 24/1/25.
//

import Foundation
import Combine

final class CoinDetailDataService {
  @Published var coinDetails: CoinDetailModel? = nil
  var coinDetailSubscription: AnyCancellable?
  let coin: CoinModel
  
  init(coin: CoinModel) {
    self.coin = coin
    getCoinsDetails()
  }
  
  func getCoinsDetails() {
    guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false")
    else { return }
    
    // TODO: Replace Combine to Structured Concurrency
    coinDetailSubscription = NetworkingManager.download(url: url)
      .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
      .sink(receiveCompletion: NetworkingManager.handlingComplition,
            receiveValue: { [weak self] (returnedCoins) in
        self?.coinDetails = returnedCoins
        self?.coinDetailSubscription?.cancel()
      })
  }
}
