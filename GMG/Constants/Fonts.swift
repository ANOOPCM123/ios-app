//
// Copyright © 2023 Singleton Commerce.
//
// All rights reserved.
//
// This software is the confidential and proprietary information of Singleton Commerce ("Confidential Information"). You
// shall not disclose such Confidential Information and shall use it only in accordance with the terms of the contract
// agreement you entered into with Singleton Commerce.

// @author Jinto Joseph
//

import Foundation

enum FontType: String {
  case Poppins
  var name: String {
    self.rawValue.capitalized
  }
}
enum FontWeight: String {
  case extraLight
  case light
  case thin
  case regular
  case medium
  case semiBold
  case bold
  case extraBold
  case black
  case extraLightItalic
  case lightItalic
  case thinItalic
  case regularItalic
  case mediumItalic
  case semiBoldItalic
  case boldItalic
  case extraBoldItalic
  case blackItalic
  
  var name: String {
    "-" + self.rawValue.capitalized
  }
}
