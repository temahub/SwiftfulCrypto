//
//  CoinImageService.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 4/1/25.
//

import Foundation
import SwiftUI
import Combine

final class CoinImageService {
  private let FOLDER_NAME = "coin_images"
  
  @Published var image: UIImage? = nil
  
  var imageSubscription: AnyCancellable?
  private let coin: CoinModel
  private let fileManager = LocalFileManager.instance
  private let imageName: String
  
  init(coin: CoinModel) {
    self.coin = coin
    self.imageName = coin.id
    getCoinImage()
  }
  
  private func getCoinImage() {
    // TODO: Replace with Kingfisher
    if let savedImage =  fileManager.getImage(imageName: imageName, foldername: FOLDER_NAME) {
      image = savedImage
      print("Retrieved image from File Manager!")
    } else {
      downloadCoinImage()
      print("Downloading image now.")
    }
  }
  
  private func downloadCoinImage() {
    guard let url = URL(string: self.coin.image) else { return }
    
    // TODO: Replace Combine to Structured Concurrency
    // TODO: Replace with Kingfisher
    imageSubscription = NetworkingManager.download(url: url)
      .tryMap({(data) -> UIImage? in
        return UIImage(data: data)
      })
      .sink(receiveCompletion: NetworkingManager.handlingComplition,
            receiveValue: { [weak self] (returnedImage) in
        guard let self = self,
        let downloadedImage = returnedImage else { return }
        self.image = downloadedImage
        self.imageSubscription?.cancel()
        self.fileManager.saveImage(image: downloadedImage, folderName: self.FOLDER_NAME, imageName: self.imageName)
      })
  }
}
