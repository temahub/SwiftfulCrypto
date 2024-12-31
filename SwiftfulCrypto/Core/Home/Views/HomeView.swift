//
//  HomeView.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 31/12/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
      ZStack {
        // background layer
        Color.theme.background
          .ignoresSafeArea()
        
        // content layer
        VStack {
          Text("Header")
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
