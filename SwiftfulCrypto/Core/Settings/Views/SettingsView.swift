//
//  SettingsView.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 10/2/25.
//

import SwiftUI

struct SettingsView: View {
  let defaultURL = URL(string: "https://www.google.com")!
  let youtubeURL = URL(string: "https://www.youtube.com/c/swiftfulthinking")!
  let coffeeURL = URL(string: "https://www.buymeacoffee.com/nicksarno")!
  let coingeckoURL = URL(string: "https://www.coingecko.com/")!
  let personalURL = URL(string: "https://github.com/temahub")!
  
  var body: some View {
    NavigationStack {
      List {
        swiftfulThinkingSection
        coinGeckoSection
        developerSection
        appSection
      }
      .font(.headline)
      .tint(.blue)
      .listStyle(GroupedListStyle())
      .navigationTitle("Settings")
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          XMarkButton()
        }
      }
    }
  }
}

extension SettingsView {
  private var swiftfulThinkingSection: some View {
    Section(header: Text("Swiftful Thinking")) {
      VStack(alignment: .leading) {
        Image("logo")
          .resizable()
          .frame(width: 100, height: 100)
          .clipShape(RoundedRectangle(cornerRadius: 20))
        Text("This app was made by following a @SwiftfulThinking course on Youtube. It uses MVVM Architecture, Combine and CoreData!")
          .font(.callout)
          .fontWeight(.medium)
          .foregroundStyle(Color.theme.accent)
      }
      .padding(.vertical)
      Link("Subscribe on Youtube 🥳", destination: youtubeURL)
      Link("Support his coffee addiction ☕️", destination: coffeeURL)
    }
  }
  
  private var coinGeckoSection: some View {
    Section(header: Text("CoinGecko")) {
      VStack(alignment: .leading) {
        Image("coingecko")
          .resizable()
          .scaledToFit()
          .frame(height: 100)
          .clipShape(RoundedRectangle(cornerRadius: 20))
        Text("The cryptocurrency data thast is used in this app comes from a free API published CoinGecko. Prices may be slightly delayed.")
          .font(.callout)
          .fontWeight(.medium)
          .foregroundStyle(Color.theme.accent)
      }
      .padding(.vertical)
      Link("Visit CoinGecko 🦎", destination: coingeckoURL)
    }
  }
  
  private var developerSection: some View {
    Section(header: Text("Developer")) {
      VStack(alignment: .leading) {
        Image("logo")
          .resizable()
          .frame(width: 100, height: 100)
          .clipShape(RoundedRectangle(cornerRadius: 20))
        Text("This app was developed by Nick Sarno. It uses SwiftUI and is written 100% in Swift. the project benefits from multi-threading, publishers/subscribers and data persistance.")
          .font(.callout)
          .fontWeight(.medium)
          .foregroundStyle(Color.theme.accent)
      }
      .padding(.vertical)
      Link("Visit Website 🧑🏻‍💻", destination: coingeckoURL)
    }
  }
  
  private var appSection: some View {
    Section(header: Text("Application")) {
      Link("Terms of Service", destination: defaultURL)
      Link("Privacy Policy", destination: defaultURL )
      Link("Company Website", destination: defaultURL )
      Link("Learn More", destination: defaultURL  )
    }
  }
}

#Preview {
  SettingsView()
}
