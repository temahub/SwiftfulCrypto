//
//  DetailViewModel.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 24/1/25.
//

import Foundation
import Combine

final class DetailViewModel: ObservableObject {
  @Published var overviewStatistics: [StatisticModel] = []
  @Published var additionalStatistics: [StatisticModel] = []
  
  @Published var coin: CoinModel
  private let coinDataService: CoinDetailDataService
  private var cancellables = Set<AnyCancellable>()
  
  init(coin: CoinModel) {
    self.coin = coin
    self.coinDataService = CoinDetailDataService(coin: coin)
    self.addSubscribers()
  }
  
  private func addSubscribers() {
    coinDataService.$coinDetails
      .combineLatest($coin)
      .map(mapDataToStatistics)
      .sink { [weak self] (returnedArrays) in
        self?.overviewStatistics = returnedArrays.overview
        self?.additionalStatistics = returnedArrays.additional
//        print("RECIVED COIN OVERVIEW DETAILS DATA:\n\(String(describing: returnedArrays.overview))")
//        print("RECIVED COIN ADDITIONAL DETAILS DATA:\n\(String(describing: returnedArrays.additional))")
      }
      .store(in: &cancellables)
  }
  
  private func mapDataToStatistics(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> (overview: [StatisticModel], additional: [StatisticModel]) {
    return (createOverviewArray(coinModel: coinModel),
            createAdditionalArray(coinModel: coinModel, coinDetailModel: coinDetailModel))
  }
  
  private func createOverviewArray(coinModel: CoinModel) -> [StatisticModel] {
    let price = coinModel.currentPrice.asCurrencyWith6Decimals()
    let pricePercentChange = coinModel.priceChangePercentage24H
    let priceStat = StatisticModel(title: "Current Price", value: price, percentageChange: pricePercentChange)
    
    let marketCap = (Locale.current.currencySymbol ?? "$") + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
    let marketCapPercentChange = coinModel.marketCapChangePercentage24H
    let marketCapStat = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentChange)
    
    let rank = "\(coinModel.rank)"
    let rankStat = StatisticModel(title: "Rank", value: rank)
    
    let volume = (Locale.current.currencySymbol ?? "$") + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
    let volumeStat = StatisticModel(title: "Volume", value: volume)
    
    return [
      priceStat, marketCapStat, rankStat, volumeStat
    ]
  }
  
  private func createAdditionalArray(coinModel: CoinModel, coinDetailModel: CoinDetailModel?) -> [StatisticModel] {
    let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
    let highStat = StatisticModel(title: "24h High", value: high)
    
    let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
    let lowStat = StatisticModel(title: "24h Low", value: low)
    
    let priceChange = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
    let pricePercentChange2 = coinModel.priceChangePercentage24H
    let priceChangeStat = StatisticModel(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChange2)
    
    let marketCapChange = (Locale.current.currencySymbol ?? "$") + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
    let marketCapPercentChange2 = coinModel.marketCapChangePercentage24H
    let marketCapChangeStat = StatisticModel(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentChange2)
    
    let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
    let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
    let blockStat = StatisticModel(title: "Block Time", value: blockTimeString)
    
    let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
    let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)
    
    return [
      highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat
    ]
  }
}
