//
//  XMarkButton.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 9/1/25.
//

import SwiftUI

struct XMarkButton: View {
  
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    Button(action: {
      print("Button tapped")
      dismiss()
    }) {
      Image(systemName: "xmark")
        .font(.headline)
    }
  }
}

#Preview {
  XMarkButton()
}
