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

struct CustomTopBarView<LeftBarItems: View, RightBarItems: View>: View {
    let leftBarItems: LeftBarItems
    let rightBarItems: RightBarItems
    var backgroundColor: Color = .white // Default background color
    var verticalPadding: CGFloat = 16 // Default vertical padding
    var leftPadding: CGFloat? // Default leading padding
    var rightPadding: CGFloat? // Default trailing padding
    var horizontalPadding: CGFloat? // Optional horizontal padding
    var alignment: VerticalAlignment = .center // Default vertical alignment

    var body: some View {
        HStack(alignment: alignment) {
            leftBarItems
            Spacer()
            rightBarItems
        }
        .padding(.vertical, verticalPadding)
        .padding(.leading, leftPadding ?? horizontalPadding ?? verticalPadding)
        .padding(.trailing, rightPadding ?? horizontalPadding ?? verticalPadding)
        .background(backgroundColor)
    }
}
