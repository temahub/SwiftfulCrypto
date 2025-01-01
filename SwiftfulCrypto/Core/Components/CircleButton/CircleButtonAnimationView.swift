//
//  CircleButtonAnimationView.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 1/1/25.
//

import SwiftUI

struct CircleButtonAnimationView: View {
  
  @Binding var animate: Bool
  
  var body: some View {
    Circle()
      .stroke(lineWidth: 5.0)
      .scale(animate ? 1.0 : 0.0)
      .opacity(animate ? 0.0 : 1.0)
      .animation(animate ? .easeOut(duration: 1.0) : .none, value: animate) // new version, old deprecated
  }
}

#Preview {
  CircleButtonAnimationView(animate: .constant(false))
    .foregroundStyle(.red)  // new version, old deprecated
    .frame(width: 100, height: 100)
}
