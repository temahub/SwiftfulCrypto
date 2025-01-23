//
//  DetailsView.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 20/1/25.
//

import SwiftUI

struct DetailLoadingView: View {
  @Binding var coin: CoinModel?
  
  var body: some View {
    ZStack {
      if let coin = coin {
        DetailView(coin: coin)
      }
    }
  }
}

struct DetailView: View {
  let coin: CoinModel
  
  init(coin: CoinModel) {
    self.coin = coin
    print("initialazing Detail View for \(String(describing: coin.name))")
  }
  
  var body: some View {
    Text(coin.name)
  }
}

#Preview {
  DetailView(coin: MockCoinModel.sampleCoin)
}
