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
import SwiftUI

extension Font {
  /// A font with the large title text style.
  static let appLargeTitle = font(type: .Poppins, weight: .bold, style: .largeTitle)
  /// A font with the title text style.
  static let appTitle = font(type: .Poppins, weight: .bold, style: .title1)
  /// A font for second level hierarchical headings.
  static let appSecondaryTitle = font(type: .Poppins, weight: .bold, style: .title2)
  /// A font for third level hierarchical headings.
  static let appTertiaryTitle = font(type: .Poppins, weight: .bold, style: .title3)
  /// A font with the headline text style.
  static let appHeadline = font(type: .Poppins, weight: .bold, style: .headline)
  /// A font with the body text style.
  static let appBody = font(type: .Poppins, weight: .regular, style: .body)
  /// A font with the callout text style.
  static let appCallout = font(type: .Poppins, weight: .regular, style: .callout)
  /// A font with the caption text style.
  static let appCaption = font(type: .Poppins, weight: .regular, style: .caption1)
  /// A font with the credits text style.
  static let appCredits = font(type: .Poppins, weight: .light, style: .caption2)
}

extension Font {
  /// Use this method for custom fonts with variable weight and style.
  /// Dynamically updates the font size with the system size.
  /// - Parameters:
  ///   - type: Cases that describe the preferred type of font.
  ///   - weight: Cases that describe the preferred weight for fonts.
  ///   - style: Constants that describe the preferred styles for fonts.
  /// - Returns: Custom font based on the parameters you specified.
    static private func font(type: FontType, weight: FontWeight, style: UIFont.TextStyle) -> Font {
    .custom(type.name + weight.name, size: UIFont.preferredFont(forTextStyle: style).pointSize)
  }
  
  /// Use this method for custom fonts with variable weight and size.
  /// Dynamically updates the font size with the system size.
  /// - Parameters:
  ///   - type: Cases that describe the preferred type of font.
  ///   - weight: Cases that describe the preferred weight for fonts.
  ///   - size: Constants that describe the preferred size for fonts.
  /// - Returns: Custom font based on the parameters you specified.
    static private func font(type: FontType, weight: FontWeight, size: CGFloat) -> Font {
    .custom(type.name + weight.name, size: size)
  }
}
