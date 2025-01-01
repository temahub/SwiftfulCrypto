//
//  HomeView.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 31/12/24.
//

import SwiftUI

struct HomeView: View {
  
  @State private var showPortfolio: Bool = false
  
  var body: some View {
    ZStack {
      // background layer
      Color.theme.background
        .ignoresSafeArea()
      
      // content layer
      VStack {
        HStack {
          CircleButtonView(iconName: showPortfolio ? "plus" : "info")
            .animation(.none, value: 0)
          Spacer()
          
          Text(showPortfolio ? "Portfolio" :"Live prices")
            .font(.headline)
            .fontWeight(.heavy)
            .foregroundStyle(Color.theme.accent)
            .animation(.none, value: 0)
          
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
        Spacer(minLength: 0)
      }
    }
  }
}

#Preview {
  NavigationStack {
    HomeView()
      .toolbar(.hidden)
  }
}
