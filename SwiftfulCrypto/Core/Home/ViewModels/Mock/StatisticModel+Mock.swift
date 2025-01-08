//
//  StatisticModel+Mock.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 7/1/25.
//

import Foundation

struct MockStatisticModel {
  static let sample1StatisticModel = StatisticModel(
    title: "Market Cap",
    value: "12.5Bn €",
    percentageChange: 25.34
  )
  
  static let sample2StatisticModel = StatisticModel(
    title: "Total Volume",
    value: "1.23Tr €"
  )
  
  static let sample3StatisticModel = StatisticModel(
    title: "Portfolio Value",
    value: "50.4K €",
    percentageChange: -12.34
  )
  
  static let StatisticModels: [StatisticModel] = [sample1StatisticModel, sample2StatisticModel]
}
