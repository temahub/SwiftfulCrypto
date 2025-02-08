//
//  DetailsView.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 20/1/25.
//

import SwiftUI

struct DetailView: View {
  @StateObject private var vm: DetailViewModel
  @State private var showFullDescription: Bool = false
  
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
      VStack {
        ChartView(coin: vm.coin)
          .padding(.vertical)
        
        VStack(spacing: 20) {
          overviewTitle
          Divider()
          
          descriptionSection
          
          overviewGrid
          additionalTitle
          Divider()
          additionalGrid
          
          websiteSection
        }
        .padding()
      }
    }
    .navigationTitle(vm.coin.name)
    .navigationBarTitleDisplayMode(.large)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        navigationBarTrailingItems
      }
    }
  }
}

extension DetailView {
  private var navigationBarTrailingItems: some View {
    HStack {
      Text(vm.coin.symbol.uppercased())
        .font(.headline)
        .foregroundStyle(Color.theme.secondaryText)
      CoinImageView(coin: vm.coin)
        .frame(width: 25, height: 25)
    }
  }
  
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
  
  private var descriptionSection: some View {
    ZStack {
      if let coinDescription = vm.coinDescription, !coinDescription.isEmpty {
        VStack(alignment: .leading) {
          Text(coinDescription)
            .lineLimit(showFullDescription ? nil : 3)
            .font(.callout)
            .foregroundStyle(Color.theme.secondaryText)
            .animation(showFullDescription ? Animation.easeInOut : .none, value: showFullDescription)
          
          Button(showFullDescription ? "Less" : "Read more...") {
              showFullDescription.toggle()
          }
          .accentColor(.blue)
          .font(.caption)
          .fontWeight(.bold)
          .padding(.vertical, 2)
        }
        .frame(width: .infinity, alignment: .leading)
      }
    }
  }
  
  private var overviewGrid: some View {
    statisticsGrid(statistics: vm.overviewStatistics)
  }
  
  private var additionalGrid: some View {
    statisticsGrid(statistics: vm.additionalStatistics)
  }
  
  private var websiteSection: some View {
    VStack(alignment: .leading, spacing: 20) {
      if let websiteString = vm.websiteURL,
         let url = URL(string: websiteString) {
        Link("Website", destination: url)
      }
      
      if let redditString = vm.redditURL,
         let url = URL(string: redditString) {
        Link("Reddit", destination: url)
      }
    }
    .accentColor(.blue)
    .frame(maxWidth: .infinity, alignment: .leading)
    .font(.headline)
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
