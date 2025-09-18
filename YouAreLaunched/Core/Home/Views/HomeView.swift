//
//  HomeView.swift
//  YouAreLaunched
//
//  Created by Michael on 9/17/25.
//

import SwiftUI

struct HomeView: View {
  
  @StateObject private var vm = HomeViewModel()
  
  var body: some View {
    VStack {
      SearchBarView(searchText: $vm.searchText)
      
      if vm.hasNoResults {
        hasNoResultPage
      } else {
        vendorList
      }
    }
  }
}

#Preview {
  HomeView()
}

// MARK: EXTENSION
extension HomeView {
  private var hasNoResultPage: some View {
    VStack {
      Text("Sorry! No results found...")
        .font(.system(size: 24, weight: .bold))
        .foregroundColor(.green)
        .padding(.bottom, 8)
      
      Text("Please try a different search request or browse businesses from the list")
        .font(.callout)
        .foregroundColor(.gray)
        .multilineTextAlignment(.center)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
  
  private var vendorList: some View {
    ScrollView {
      LazyVStack(spacing: 20) {
        ForEach(vm.filteredVendors) { vendor in
          VendorRowView(vendor: vendor)
        }
      }
      .padding(.vertical, 8)
    }
    .scrollIndicators(.hidden)
  }
}
