//
//  VendorRowView.swift
//  YouAreLaunched
//
//  Created by Michael on 9/17/25.
//

import SwiftUI

struct VendorRowView: View {
  
  let vendor: Vendor
  
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      imageLayer
      .overlay {
        imageOverlayContent
      }
      companyDesription
    }
    .padding(.horizontal)
  }
}

#Preview {
  VendorRowView(vendor: Vendor.mok)
}

//MARK: EXTENSIONS
extension VendorRowView {
  
  private var imageLayer: some View {
    AsyncImage(url: URL(string: vendor.cover_photo.media_url)) { phase in
      if let image = phase.image {
        image.resizable()
          .scaledToFill()
          .frame(width: 343, height: 170)
          .clipShape(RoundedRectangle(cornerRadius: 12))
          .animation(.easeIn(duration: 0.5), value: image)
      } else {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 343, height: 170)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
        }
      }
    }
    
  }
  
  private var imageOverlayContent: some View {
    VStack {
        Button {
          //TODO: Add vendor to favorites
        } label: {
          Image(systemName: vendor.favorited ? "bookmark.fill" : "bookmark")
            .frame(width: 36, height: 36)
            .foregroundStyle(vendor.favorited ? Color.white : Color.green)
            .background(vendor.favorited ? Color.green : Color.white)
            .cornerRadius(16)
        }
      .frame(maxWidth: .infinity, alignment: .topTrailing)
      
      Spacer()

        Text(vendor.area_served)
          .font(.footnote)
          .foregroundStyle(Color.black.opacity(0.75))
          .padding(.vertical, 4)
          .padding(.horizontal, 8)
          .background(Color.white)
          .cornerRadius(16)
          .frame(maxWidth: .infinity, alignment: .bottomLeading)

    }
    .padding(8)
  }
  
  private var companyDesription: some View {
    VStack(alignment: .leading, spacing: 0) {
    Text(vendor.company_name)
      .font(.headline)
      .foregroundColor(.black.opacity(0.75))
      
      HStack {
        Image(systemName: "lasso.badge.sparkles")
          .foregroundStyle(Color.gray)
        Text(vendor.shop_type)
          .font(.callout)
          .foregroundColor(.black.opacity(0.50))
      }
      
      HStack {
        ForEach(vendor.tags, id: \.self, content: { tag in
          Text("· " + tag.name)
            .font(.subheadline)
            .foregroundColor(.gray)
        })
      }
    }
  }
}
