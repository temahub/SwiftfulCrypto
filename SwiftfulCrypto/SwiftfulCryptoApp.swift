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
  @State private var showLaunchView: Bool = true
  
  init() {
    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
  }
  
  var body: some Scene {
    WindowGroup {
      ZStack {
        NavigationStack { // new version, old deprecated
          HomeView()
            .toolbar(.hidden) // new version, old deprecated
        }
        .environmentObject(vm)
        
        ZStack {
          if showLaunchView {
            LaunchView(showLaunchView: $showLaunchView)
              .transition(.move(edge: .leading))
          }
        }
        .zIndex(2.0)
      }
      
      
    }
  }
}
