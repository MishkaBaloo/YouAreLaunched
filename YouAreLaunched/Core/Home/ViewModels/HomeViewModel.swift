//
//  HomeViewModel.swift
//  YouAreLaunched
//
//  Created by Michael on 9/17/25.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
  @Published var allVendors: [Vendor] = []
  @Published var filteredVendors: [Vendor] = []
  @Published var isLoading: Bool = false
  @Published var searchText: String = ""
  @Published var sortOption: SortOption = .companyName
  
  private var cancellables = Set<AnyCancellable>()
  private let service: VendorServiceProtocol
  var hasNoResults: Bool { filteredVendors.isEmpty == true }
  
  enum SortOption {
    case companyName
  }
  
  init(service: VendorServiceProtocol = MockVendorService()) {
    self.service = service
    addSubscribers()
    Task {
      await loadInitial()
    }
  }
  
  private func addSubscribers() {
    $searchText
      .combineLatest($allVendors, $sortOption)
      .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
      .map(filterAndSortVendors)
      .sink { [weak self] returned in
        self?.filteredVendors = returned
      }
      .store(in: &cancellables)
  }
  
  // MARK: Search text
  private func filterAndSortVendors(text: String, vendors: [Vendor], sort: SortOption) -> [Vendor] {
    var updated = filterVendors(text: text, vendors: vendors)
    sortVendors(sort: sort, vendors: &updated)
    if text.count >= 3 {
      return updated
    } else {
      return vendors
    }
  }
  
  private func filterVendors(text: String, vendors: [Vendor]) -> [Vendor] {
    guard !text.isEmpty else { return vendors }
    let lowercased = text.lowercased()
    return vendors.filter { $0.company_name.lowercased().contains(lowercased) }
  }
  
  private func sortVendors(sort: SortOption, vendors: inout [Vendor]) {
    switch sort {
    case .companyName:
      vendors.sort { $0.company_name < $1.company_name }
    }
  }
  
  // MARK: Data loading
  func loadInitial() async {
    do {
      let vendors = try await service.fetchVendors()
      self.allVendors = vendors
      self.filteredVendors = vendors
    } catch {
      print("Error loading vendors: \(error)")
    }
  }
}
