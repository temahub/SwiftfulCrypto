//
//  CoinImageService.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 4/1/25.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
  
  @Published var image: UIImage? = nil
  
  var imageSubscription: AnyCancellable?
  private let coin: CoinModel
  
  init(coin: CoinModel) {
    self.coin = coin
    getCoinImage()
  }
  
  private func getCoinImage() {
    guard let url = URL(string: self.coin.image) else { return }
    
    // TODO: Replace Combine to Structured Concurrency
    imageSubscription = NetworkingManager.download(url: url)
      .tryMap({(data) -> UIImage? in
        return UIImage(data: data)
      })
      .sink(receiveCompletion: NetworkingManager.handlingComplition,
            receiveValue: { [weak self] (returnedImage) in
        self?.image = returnedImage
        self?.imageSubscription?.cancel()
      })
  }
}
