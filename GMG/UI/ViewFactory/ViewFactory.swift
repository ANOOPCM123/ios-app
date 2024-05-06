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

struct ViewFactory {
    /// Creating components from anywhere
    @ViewBuilder
    static func make<T>(
        item: T,
        proxy: GeometryProxy,
        itemTappedCallback: @escaping (HomePageItem) -> Void
    ) -> some View  {
        if let item = item as? HomePageSection{
            switch item.widget_type ?? "" {
            case KeyConstants.HomeViewWidgets.actionList.rawValue:
                let actionItems = item.items?.compactMap({$0})
                if !(actionItems ?? []).isEmpty {
                    QuickActionsHorizontalView(proxy: proxy, actionItems: actionItems ?? [], itemTappedCallback: itemTappedCallback)
                } else {
                    EmptyView()
                }
            case KeyConstants.HomeViewWidgets.navigationList.rawValue:
                let brandItems = item.items?.compactMap({$0})
                if !(brandItems ?? []).isEmpty {
                    BrandActionsHorizontalView(proxy: proxy, title: item.title, actionItems: brandItems ?? [])
                } else {
                    EmptyView()
                }
            default:
                EmptyView()
            }
        }
    }
}
