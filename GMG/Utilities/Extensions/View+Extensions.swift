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
    /// SafeArea will return the default safearea froms windows property of the application class
    var safeArea: UIEdgeInsets {
        get{
            guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
                return .zero
            }
            guard let safeArea = screen.windows.first?.safeAreaInsets else {
                return .zero
            }
            return safeArea
        }
    }
    /// Setting navigation modifiers to the navigation ViewModifier
    func navigationBar(title : String = "",
                       displayMode : NavigationBarItem.TitleDisplayMode = .automatic, titleColor : UIColor = .clear, backgroundColor : UIColor = .white, showNavigationBar: Bool = true) -> some View{
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleColor, title: title, displayMode: displayMode, showNavigationBar: showNavigationBar))
    }
    ///Setting hidden property to any view, using opacity property
    func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }
    ///Setting cornerRadius to any view with specific corners
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}

extension View {
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    ///
    ///     Text("Label")
    ///         .isHidden(true)
    ///
    /// Example for complete removal:
    ///
    ///     Text("Label")
    ///         .isHidden(true, remove: true)
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
