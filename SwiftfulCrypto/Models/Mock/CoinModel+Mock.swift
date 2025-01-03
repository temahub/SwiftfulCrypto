//
//  CoinModel+Mock.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 2/1/25.
//

import Foundation

struct MockCoinModel {
  static let sampleCoin = CoinModel(
    id: "bitcoin",
    symbol: "btc",
    name: "Bitcoin",
    image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
    currentPrice: 96638,
    marketCap: 1913534058416,
    marketCapRank: 1,
    fullyDilutedValuation: 2029040267515,
    totalVolume: 32914513906,
    high24H: 96576,
    low24H: 93052,
    priceChange24H: 3305.88,
    priceChangePercentage24H: 3.54205,
    marketCapChange24H: 65563779180,
    marketCapChangePercentage24H: 3.54788,
    circulatingSupply: 19804543.0,
    totalSupply: 21000000.0,
    maxSupply: 21000000.0,
    ath: 108135,
    athChangePercentage: -10.70649,
    athDate: "2024-12-17T15:02:41.429Z",
    atl: 67.81,
    atlChangePercentage: 142295.95858,
    atlDate: "2013-07-06T00:00:00.000Z",
    lastUpdated: "2025-01-02T10:24:09.233Z",
    sparklineIn7D: SparklineIn7D(price: [98247.92246369661, 98015.2331340629]),
    priceChangePercentage24HInCurrency: 3.5420528908492255,
    currentHoldings: 2
  )
  
  static let mockCoins: [CoinModel] = [sampleCoin]
}
