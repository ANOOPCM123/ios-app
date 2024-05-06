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

extension View {
    func conditionalToolbar(hideTabBar: Bool) -> some View {
        if #available(iOS 16.0, *) {
            return self.toolbar(.hidden, for: .tabBar)
        } else {
            return self
        }
    }
}
extension View {
    func conditionalSafeArea(top: Bool) -> some View {
        if top{
            return AnyView(self.edgesIgnoringSafeArea(.top))
        }else{
            return AnyView(self)
        }
    }
}
