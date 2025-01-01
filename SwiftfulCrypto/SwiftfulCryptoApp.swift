//
//  SwiftfulCryptoApp.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 30/12/24.
//

import SwiftUI

@main
struct SwiftfulCryptoApp: App {
    var body: some Scene {
        WindowGroup {
          NavigationStack {
            HomeView()
              .toolbar(.hidden) // new version, old deprecated
          }
        }
    }
}
