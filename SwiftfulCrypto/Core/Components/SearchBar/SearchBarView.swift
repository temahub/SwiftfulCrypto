//
//  SearchBarView.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 6/1/25.
//

import SwiftUI

struct SearchBarView: View {
  
  @Binding var searchText: String
  @FocusState private var isFocused: Bool
  
  var body: some View {
    HStack {
      Image(systemName: "magnifyingglass")
        .foregroundStyle(
          searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent)
      
      TextField("Search by name or symbol...", text: $searchText )
        .focused($isFocused)
        .autocorrectionDisabled(true)
        .keyboardType(.asciiCapable)
        .foregroundStyle(Color.theme.accent)
        .overlay(
          Image(systemName: "xmark.circle.fill")
            .padding()
            .offset(x: 10)
            .foregroundStyle(Color.theme.accent)
            .opacity(
              searchText.isEmpty ? 0.0 : 1.0 )
            .onTapGesture {
//              UIApplication.shared.endEditing() // Dismiss Keyboard for iOS 14 and earlier
              isFocused = false
              searchText = ""
            }
          ,alignment: .trailing
        )
    }
    .font(.headline)
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 25)
        .fill(Color.theme.background)
        .shadow(
          color: Color.theme.accent.opacity(0.15),
          radius: 10, x: 0, y: 0)
    )
    .padding()
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  SearchBarView(searchText: .constant(""))
}

#Preview(traits: .sizeThatFitsLayout) {
  SearchBarView(searchText: .constant(""))
    .preferredColorScheme(.dark)
}
