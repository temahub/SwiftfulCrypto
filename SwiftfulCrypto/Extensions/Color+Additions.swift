//
//  Color.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 30/12/24.
//

import SwiftUI

extension Color {
  static let theme = ColorTheme()
  static let launch = LaunchTheme()
}

struct ColorTheme {
  let accent = Color("AccentColor")
  let background = Color("BackgroundColorCustom")
  let green = Color("GreenColorCustom")
  let red = Color("RedColorCustom")
  let secondaryText = Color("SecondaryTextColorCustom")
}

struct LaunchTheme {
  let accent = Color("LaunchAccentColor")
  let background = Color("LaunchBackgroundColor")
}
