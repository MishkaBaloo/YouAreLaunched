//
//  SearchBarView.swift
//  YouAreLaunched
//
//  Created by Michael on 9/17/25.
//

import SwiftUI

struct SearchBarView: View {
  
  @Binding var searchText: String
  
  var body: some View {
    HStack {
      TextField("Search...", text: $searchText)
        .submitLabel(.search)
        .foregroundStyle(Color.black)
        .overlay(alignment: .trailing) {
          if searchText.isEmpty {
            Image(systemName: "magnifyingglass")
              .padding()
              .offset(x: 10) // bigger area for TapGesture
              .foregroundStyle(Color.gray)
          } else {
            Image(systemName: "xmark.circle.fill")
              .padding()
              .offset(x: 10)
              .foregroundStyle(Color.gray)
              .onTapGesture {
                UIApplication.shared.endEditing()
                searchText = ""
              }
          }
        }
    }
    .font(.callout)
    .padding(12)
    .background(
      RoundedRectangle(cornerRadius: 16.0)
        .fill(Color.white)
        .shadow(
          color: .gray.opacity(0.25),
          radius: 2, x: 0.0, y: 0.0
        )
    )
    .padding()
  }
}

#Preview {
  SearchBarView(searchText: .constant(""))
}
