//
//  HomeView.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 31/12/24.
//

import SwiftUI

struct HomeView: View {
  
  @EnvironmentObject private var vm: HomeViewModel
  @State private var showPortfolio: Bool = false  // animate right
  @State private var showProtfolioView: Bool = false  // new sheet
  
  var body: some View {
    ZStack {
      // background layer
      Color.theme.background
        .ignoresSafeArea()
        .sheet(isPresented: $showProtfolioView) {
          PortfolioView()
            .environmentObject(vm)
        }
      
      // content layer
      VStack {
        homeHeader
        
        HomeStatsView(showPortfolio: $showPortfolio)
        
        SearchBarView(searchText: $vm.searchText)
        
        columnTitles
        
        if !showPortfolio {
          allCoinsList
            .transition(.move(edge: .leading))
        } else {
          portfolioCoinsList
            .transition(.move(edge: .trailing))
        }
        
        Spacer(minLength: 0)
      }
    }
  }
}

extension HomeView {
  private var homeHeader: some View {
    HStack {
      CircleButtonView(iconName: showPortfolio ? "plus" : "info")
        .animation(.none, value: false)
        .onTapGesture {
          if showPortfolio {
            showProtfolioView.toggle()
          }
        }
        .background(
          CircleButtonAnimationView(animate: $showPortfolio)
        )
      Spacer()
      
      Text(showPortfolio ? "Portfolio" :"Live prices")
        .font(.headline)
        .fontWeight(.heavy)
        .foregroundStyle(Color.theme.accent)  // new version, old deprecated
        .animation(.none, value: false)
      
      Spacer()
      CircleButtonView(iconName: "chevron.right")
        .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
        .onTapGesture {
          withAnimation(.spring()) {
            showPortfolio.toggle()
          }
        }
    }
    .padding(.horizontal)
  }
  
  private var allCoinsList: some View {
    List {
      ForEach(vm.allCoins) { coin in
        CoinRowView(coin: coin, showHoldingsColumn: false)
          .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
      }
    }
    .listStyle(.plain)
  }
  
  private var portfolioCoinsList: some View {
    List {
      ForEach(vm.portfolioCoins) { coin in
        CoinRowView(coin: coin, showHoldingsColumn: true)
          .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
      }
    }
    .listStyle(.plain)
  }
  
  private var columnTitles: some View {
    HStack {
      Text("Coins")
      Spacer()
      if showPortfolio {
        Text("Holdings")
      }
      Text("Price")
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
    .font(.caption)
    .foregroundStyle(Color.theme.secondaryText)
    .padding(.horizontal, 10)
  }
}

#Preview {
  NavigationStack {
    HomeView()
      .toolbar(.hidden)
  }
  .environmentObject(HomeViewModel())
}

#Preview {
  NavigationStack {
    HomeView()
      .toolbar(.hidden)
      .preferredColorScheme(.dark)
  }
  .environmentObject(HomeViewModel())
}
