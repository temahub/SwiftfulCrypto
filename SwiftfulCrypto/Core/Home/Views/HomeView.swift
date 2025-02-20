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
  @State private var showSettingsView: Bool = false // new sheet
  
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
      .sheet(isPresented: $showSettingsView) {
        SettingsView()
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
          } else {
            showSettingsView.toggle()
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
        NavigationLink(value: coin) { // new approach instead of depricated NavigationLink(destination, isActive, label:)
          CoinRowView(coin: coin, showHoldingsColumn: false)
        }
        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
      }
    }
    .listStyle(.plain)
    .refreshable { vm.reloadData() }  // iOS 15.0+
    .navigationDestination(for: CoinModel.self) { DetailView(coin: $0) } // iOS 16.0, new approach instead of depricated NavigationLink(destination, isActive, label:)
  }
  
  private var portfolioCoinsList: some View {
    List {
      ForEach(vm.portfolioCoins) { coin in
        NavigationLink(value: coin) { // new approach instead of depricated NavigationLink(destination, isActive, label:)
          CoinRowView(coin: coin, showHoldingsColumn: true)
        }
        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
      }
    }
    .listStyle(.plain)
    .refreshable { vm.reloadData() }  // iOS 15.0+
    .navigationDestination(for: CoinModel.self) { DetailView(coin: $0) } // iOS 16.0, new approach instead of depricated NavigationLink(destination, isActive, label:)
  }
  
  private var columnTitles: some View {
    HStack {
      HStack(spacing: 4) {
        Text("Coin")
        Image(systemName: "chevron.down")
          .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0)
          .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
      }
      .onTapGesture {
        withAnimation(.default) {
          vm.sortOption.toggleRank()
        }
      }
      
      Spacer()
      if showPortfolio {
        HStack(spacing: 4) {
          Text("Holdings")
          Image(systemName: "chevron.down")
            .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0 : 0.0)
            .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
        }
        .onTapGesture {
          withAnimation(.default) {
            vm.sortOption.toggleHoldings()
          }
        }
      }
      HStack(spacing: 4) {
        Text("Price")
        Image(systemName: "chevron.down")
          .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0 : 0.0)
          .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
      }
      .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
      .onTapGesture {
        withAnimation(.default) {
          vm.sortOption.togglePrice()
        }
      }
      
      Button(action: {
        withAnimation(.linear(duration: 2.0)) {
          vm.reloadData()
        }
      }) {
        Image(systemName: "goforward")
      }
      .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0))
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
