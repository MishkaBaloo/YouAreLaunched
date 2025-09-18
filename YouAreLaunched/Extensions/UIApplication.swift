//
//  UIApplication.swift
//  YouAreLaunched
//
//  Created by Michael on 9/18/25.
//

import Foundation
import SwiftUI

extension UIApplication {
  func endEditing() {
    sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
