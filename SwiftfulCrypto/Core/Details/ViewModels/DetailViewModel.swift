//
//  DetailViewModel.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 24/1/25.
//

import Foundation
import Combine

final class DetailViewModel: ObservableObject {
  private let coinDataService: CoinDetailDataService
  private var cancellables = Set<AnyCancellable>()
  
  init(coin: CoinModel) {
    self.coinDataService = CoinDetailDataService(coin: coin)
    self.addSubscribers()
  }
  
  private func addSubscribers() {
    coinDataService.$coinDetails
      .sink { (recivedCoinDetails) in
        print("RECIVED COIN DETAILS DATA:\n\(String(describing: recivedCoinDetails))")
      }
      .store(in: &cancellables)
  }
}
