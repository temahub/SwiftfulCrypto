//
//  Date+Additions.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 7/2/25.
//

import Foundation

extension Date {
  // 2024-12-17T15:02:41.429Z
  init(coinGeckoString: String) {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let date = formatter.date(from: coinGeckoString) ?? Date()
    self.init(timeInterval: 0, since: date)
  }
  
  private var shortFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
  }
  
  func asShortDateString() -> String {
    return shortFormatter.string(from: self)
  }
}
