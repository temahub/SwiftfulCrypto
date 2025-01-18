//
//  HapticManager.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 18/1/25.
//

import Foundation
import SwiftUI

final class HapticManager {
  static private let generator = UINotificationFeedbackGenerator()
  
  static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
    generator.notificationOccurred(type)
  }
}
