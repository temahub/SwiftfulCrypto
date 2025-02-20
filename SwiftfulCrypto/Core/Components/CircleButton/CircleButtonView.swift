//
//  CircleButtonView.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 31/12/24.
//

import SwiftUI

struct CircleButtonView: View {
  
  let iconName: String
  
  var body: some View {
    Image(systemName: iconName)
      .font(.headline)
      .foregroundStyle(Color.theme.accent)  // new version, old deprecated
      .frame(width: 50, height: 50)
      .background(
        Circle()
          .foregroundStyle(Color.theme.background)  // new version, old deprecated
      )
      .shadow(
        color: Color.theme.accent.opacity(0.25),
        radius: 10, x: 0, y: 0)
      .padding()
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  Group {
    CircleButtonView(iconName: "info")
      .padding()
    
    CircleButtonView(iconName: "plus")
      .padding()
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  Group {
    CircleButtonView(iconName: "info")
      .padding()
    
    CircleButtonView(iconName: "plus")
      .padding()
      .preferredColorScheme(.dark)
  }
}

