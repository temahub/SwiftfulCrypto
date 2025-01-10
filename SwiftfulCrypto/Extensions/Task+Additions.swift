//
//  Task+Additions.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 10/1/25.
//

import Foundation

extension Task where Success == Never, Failure == Never {
  static func sleep(seconds: Double) async throws {
    let nanoseconds = UInt64(seconds * 1_000_000_000)
    try await Task.sleep(nanoseconds: nanoseconds)
  }
}
