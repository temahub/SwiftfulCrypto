//
//  UIApplication+Additions.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 6/1/25.
//

import Foundation
import SwiftUI

extension UIApplication {
  // Dismiss Keyboard for iOS 14 and earlier
  func endEditing() {
    sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
