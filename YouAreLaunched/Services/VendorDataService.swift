//
//  VendorDataService.swift
//  YouAreLaunched
//
//  Created by Michael on 9/17/25.
//

import Foundation

protocol VendorServiceProtocol {
  func fetchVendors() async throws -> [Vendor]
}

final class MockVendorService: VendorServiceProtocol {
  func fetchVendors() async throws -> [Vendor] {
    guard let url = Bundle.main.url(forResource: "vendors", withExtension: "json") else {
      throw URLError(.fileDoesNotExist)
    }
    let data = try Data(contentsOf: url)
    let decoded = try JSONDecoder().decode(VendorsResponse.self, from: data)
    return decoded.vendors
  }
}
