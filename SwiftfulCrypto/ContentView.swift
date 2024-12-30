//
//  ContentView.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 30/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      ZStack {
        Color.theme.background
          .ignoresSafeArea()
        
        VStack(spacing: 40) {
          Text("Accent Color")
            .foregroundStyle(Color.theme.accent)
          
          Text("Secondary text color")
            .foregroundStyle(Color.theme.secondaryText)
          
          Text("Red color")
            .foregroundStyle(Color.theme.red)
          
          Text("Green color")
            .foregroundStyle(Color.theme.green)
        }
        .font(.headline)
      }
    }
}

#Preview {
    ContentView()
}
