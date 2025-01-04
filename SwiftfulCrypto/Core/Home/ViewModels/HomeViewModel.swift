//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 3/1/25.
//

import Foundation

class HomeViewModel: ObservableObject {
  @Published var allCoins: [CoinModel] = []
  @Published var portfolioCoins: [CoinModel] = []
  
  init() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
      self.allCoins.append(MockCoinModel.sampleCoin)
      self.portfolioCoins.append(MockCoinModel.sampleCoin)
    }
  }
}
