//
//  PortfolioView.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 8/1/25.
//

import SwiftUI

struct PortfolioView: View {
  
  @EnvironmentObject private var vm: HomeViewModel
  @FocusState private var isFocused: Bool
  @State private var selectedCoin: CoinModel? = nil
  @State private var quantityText: String = ""
  @State private var showCheckmark: Bool = false
  
  var body: some View {
    NavigationStack {
      ScrollView {
        VStack(alignment: .leading, spacing: 0) {
          SearchBarView(searchText: $vm.searchText)
          
          coinLogoList
          
          if selectedCoin != nil {
            portfolioSection
          }
        }
      }
      .navigationTitle("Edit Portfolio")
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          XMarkButton()
        }
        ToolbarItem(placement: .topBarTrailing) {
          trailingNavBarButtons
        }
      }
    }
  }
}

extension PortfolioView {
  private var coinLogoList: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      LazyHStack(spacing: 10) {
        ForEach(vm.allCoins) { coin in
          CoinLogoView(coin: coin)
            .frame(width: 75)
            .padding(4)
            .onTapGesture {
              withAnimation(.easeIn) {
                selectedCoin = coin
              }
            }
            .background {
              RoundedRectangle(cornerRadius: 10)
                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear,
                        lineWidth: 1)
            }
        }
      }
//      .padding(.vertical, 4)
      .frame(height: 120)
      .padding(.leading)
    }
  }
  
  private var portfolioSection: some View {
    VStack(spacing: 20) {
      HStack {
        Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
        Spacer()
        Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
      }
      Divider()
      HStack {
        Text("Amount holding:")
        Spacer()
        TextField("Ex: 1.4", text: $quantityText)
          .multilineTextAlignment(.trailing)
          .keyboardType(.decimalPad)
      }
      Divider()
      HStack {
        Text("Current value:")
        Spacer()
        Text(getCurrentValue().asCurrencyWith2Decimals())
      }
    }
    .padding(.top, 20)
    .padding()
    .font(.headline)
  }
  
  private var trailingNavBarButtons: some View {
    HStack(spacing: 10) {
      Image(systemName: "checkmark")
        .foregroundStyle(Color.theme.green)
        .opacity(showCheckmark ? 1.0 : 0.0)
      Button(action: {
        saveButtonPressed()
      }) {
        Text("Save".uppercased())
      }
      .opacity(
        (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0
      )
      
    }
    .font(.headline)
  }
  
  private func getCurrentValue() -> Double {
    if let quantity =  Double(quantityText),
    let price = selectedCoin?.currentPrice {
      return quantity * price
    }
    return 0
  }
  
  private func saveButtonPressed() {
//    guard let coin = selectedCoin else { return }
    guard (selectedCoin != nil) else { return }
    
    // save to portfolio
    
    
    // show checkmark
    withAnimation(.easeIn) {
      showCheckmark = true
      removeSelectedCoin()
    }
    
    // hide keyboard
    isFocused = false
    
    // remove chackmark after delay
    Task {
      try await Task.sleep(seconds: 2)
      await MainActor.run {
        withAnimation(.easeOut) {
          showCheckmark = false
        }
      }
    }
  }
  
  private func removeSelectedCoin() {
    selectedCoin = nil
    vm.searchText = ""
  }
}

#Preview {
  PortfolioView()
    .environmentObject(HomeViewModel())
}

#Preview {
  PortfolioView()
    .environmentObject(HomeViewModel())
    .preferredColorScheme(.dark)
}
