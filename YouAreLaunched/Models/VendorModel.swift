//
//  VendorModel.swift
//  YouAreLaunched
//
//  Created by Michael on 9/17/25.
//

import Foundation
import SwiftUI

struct VendorsResponse: Decodable {
  let vendors: [Vendor]
}

struct Vendor: Identifiable, Decodable, Equatable {
  let id: Int
  let company_name: String
  let area_served: String
  let shop_type: String
  let favorited: Bool
  let follow: Bool
  let business_type: String
  let cover_photo: Media
  let categories: [Category]
  let tags: [Tag]
  
  static var mok: Self {
    Vendor(
      id: 99,
      company_name: "Florists + Fashion",
      area_served: "Newry",
      shop_type: "Bike Shop",
      favorited: false,
      follow: false,
      business_type: "",
      cover_photo: Media(
        id: 984,
        media_url: "https://cdn-staging.chatsumer.app/eyJidWNrZXQiOiJjaGF0c3VtZXItZ2VuZXJhbC1zdGFnaW5nLXN0b3JhZ2UiLCJrZXkiOiIxMy84ZjMzZTgyNy0yNzIxLTQ3ZjctYjViNS0zM2Q5Y2E2MTM1OGQuanBlZyJ9",
        media_type: "image"
      ),
      categories: [
        Category(
          id: 40,
          name: "Florists",
          image: Media(
            id: 1348,
            media_url: "https://media-staging.chatsumer.app/48/1830f855-6315-4d3c-a5dc-088ea826aef2.svg",
            media_type: "image"
          )
        )],
      tags: [
        Tag(
          id: 99,
          name: "BMX",
          purpose: "shop"
        )
      ]
    )
  }
}

struct Media: Decodable, Equatable {
  let id: Int
  let media_url: String
  let media_type: String
}

struct Category: Decodable, Equatable {
  let id: Int
  let name: String
  let image: Media
}

struct Tag: Decodable, Equatable, Hashable {
  let id: Int
  let name: String
  let purpose: String
}
