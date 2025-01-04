//
//  SwiftfulCryptoApp.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 30/12/24.
//

import SwiftUI

@main
struct SwiftfulCryptoApp: App {
  
  @StateObject private var vm = HomeViewModel()
  
  var body: some Scene {
    WindowGroup {
      NavigationStack { // new version, old deprecated
        HomeView()
          .toolbar(.hidden) // new version, old deprecated
      }
      .environmentObject(vm)
    }
  }
}
