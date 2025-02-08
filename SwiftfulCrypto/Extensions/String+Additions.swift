//
//  String+Additions.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 8/2/25.
//

import Foundation

extension String {
  var removingHTMLOccurances: String {
    return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
  }
}
