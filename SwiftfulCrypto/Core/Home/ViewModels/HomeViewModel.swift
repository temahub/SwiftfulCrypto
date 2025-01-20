//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 3/1/25.
//

import Foundation
import Combine
import SwiftUICore

final class HomeViewModel: ObservableObject {
  
  @Published var statistics: [StatisticModel] = []
  
  @Published var allCoins: [CoinModel] = []
  @Published var portfolioCoins: [CoinModel] = []
  @Published var isLoading: Bool = false
  @Published var searchText: String = ""
  @Published var sortOption: SortOption = .holdings
  
  private let coinDataService = CoinDataService()
  private let marketDataService = MarketDataService()
  private let portfolioDataService = PortfolioDataService()
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    addSubscribers()
  }
  
  func addSubscribers() {
    // updates allCoins
    // TODO: Replace Combine to Structured Concurrency
    $searchText
      .combineLatest(coinDataService.$allCoins, $sortOption)
      .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
      .map(filterAndSortCoins)
      .sink { [weak self] (returnedCoins) in
        self?.allCoins = returnedCoins
      }
      .store(in: &cancellables)
    
    // updates portfolioCoins
    // TODO: Replace Combine to Structured Concurrency
    $allCoins
      .combineLatest(portfolioDataService.$savedEntities)
      .map(mapAllCoinsToPortfolioCoins)
      .sink { [weak self] (returnedCoins) in
        guard let self = self else { return }
        self.portfolioCoins = self.sortOption.sortPortfolioCoinsIfNeeded(returnedCoins)
      }
      .store(in: &cancellables)
    
    // updates global market data
    // TODO: Replace Combine to Structured Concurrency
    marketDataService.$marketData
      .combineLatest($portfolioCoins)
      .map(mapGlobalMarketData)
      .sink { [weak self] (returnedStats) in
        self?.statistics = returnedStats
        self?.isLoading = false
      }
      .store(in: &cancellables)
  }
  
  private func filterAndSortCoins(text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel] {
    var updatedCoins = filterCoins(text: text, coins: coins)
    // sort
    updatedCoins.sort(by: sort.sortCoins)
    
    return updatedCoins
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
  
  func updatePortfolio(coin: CoinModel, amount: Double) {
    portfolioDataService.updatePortfolio(coin: coin, amount: amount)
  }
  
  func reloadData() {
    isLoading = true
    coinDataService.getCoins()
    marketDataService.getmarketData()
    HapticManager.notification(type: .success)
  }
  
  private func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
    allCoins
      .compactMap { (coin) -> CoinModel? in
        guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else { return nil }
        
        return coin.updateHoldings(amount: entity.amount)
      }
  }
  
  private func mapGlobalMarketData(data: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
    var stats: [StatisticModel] = []
    guard let data = data else { return stats }
    
    let marketCap = StatisticModel(title: "Market Cap",
                                   value: data.marketCap,
                                   percentageChange: data.marketCapChangePercentage24HUsd)
    let volume = StatisticModel(title: "24h Volume", value: data.volume)
    let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
    
    let portfolioValue = portfolioCoins
      .map({ $0.currentHoldingsValue })
      .reduce(0, +)
    
    let previuosValue = portfolioCoins
      .map { (coin) -> Double in
        let currentValue = coin.currentHoldingsValue
        let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
        // %25 -> 25 -> 0.25
        let previousValue = currentValue / (1 + percentChange)
        return previousValue
      }
      .reduce(0, +)
    
    let percentageChange = ((portfolioValue - previuosValue) / previuosValue) * 100
    
    let portfolio = StatisticModel(title: "Portfolio Value",
                                   value: portfolioValue.asCurrencyWith2Decimals(),
                                   percentageChange: percentageChange)
    
    stats.append(contentsOf: [
      marketCap,
      volume,
      btcDominance,
      portfolio
    ])
    
    return stats
  }
}

extension HomeViewModel {
  enum SortOption {
    case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    
    var sortCoins: (CoinModel, CoinModel) -> Bool {
      switch self {
      case .rank, .holdings:
        return { $0.rank < $1.rank }
      case .rankReversed, .holdingsReversed:
        return { $0.rank > $1.rank }
      case .price:
        return { $0.currentPrice > $1.currentPrice }
      case .priceReversed:
        return { $0.currentPrice < $1.currentPrice }
      }
    }
    
    var sortPortfolioCoinsIfNeeded: ([CoinModel]) -> [CoinModel] {
      switch self {
      case .holdings:
        return { $0.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue }) }
      case .holdingsReversed:
        return { $0.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue }) }
      default:
        return { $0 }
      }
    }
  }
}
