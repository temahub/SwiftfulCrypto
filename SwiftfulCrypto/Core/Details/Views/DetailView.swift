//
//  DetailsView.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 20/1/25.
//

import SwiftUI

struct DetailView: View {
  @StateObject private var vm: DetailViewModel
  private let columns: [GridItem] = [
    GridItem(.flexible()),
    GridItem(.flexible())
  ]
  private let spacing: CGFloat = 30
  
  init(coin: CoinModel) {
    _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    print("initialazing Detail View for \(String(describing: coin.name))")
  }
  
  var body: some View {
    ScrollView {
      VStack(spacing: 20) {
        Text("")
          .frame(height: 150)
        
        overviewTitle
        Divider()
        overviewGrid
        
        additionalTitle
        Divider()
        additionalGrid
      }
      .padding()
    }
    .navigationTitle(vm.coin.name)
    .navigationBarTitleDisplayMode(.large)
  }
}

extension DetailView {
  private var overviewTitle: some View {
    Text("Overview")
      .font(.title)
      .bold()
      .foregroundStyle(Color.theme.accent)
      .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  private var additionalTitle: some View {
    Text("Additional Details")
      .font(.title)
      .bold()
      .foregroundStyle(Color.theme.accent)
      .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  private var overviewGrid: some View {
    statisticsGrid(statistics: vm.overviewStatistics)
  }
  
  private var additionalGrid: some View {
    statisticsGrid(statistics: vm.additionalStatistics)
  }
  
  private func statisticsGrid(statistics: [StatisticModel]) -> some View {
    LazyVGrid(
      columns: columns,
      alignment: .leading,
      spacing: spacing,
      pinnedViews: []
    ) {
      ForEach(statistics) { stat in
        StatisticView(stat: stat)
      }
    }
  }
}

#Preview {
  NavigationView {
    DetailView(coin: MockCoinModel.sampleCoin)
  }
}
