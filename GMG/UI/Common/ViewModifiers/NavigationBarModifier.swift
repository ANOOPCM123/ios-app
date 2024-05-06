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

import SwiftUI
/// NavigationBarModifier is used to add modifications for the default navigation bar appearance..
struct NavigationBarModifier : ViewModifier {
    var title : String?
    var displayMode: NavigationBarItem.TitleDisplayMode = .inline
    var backgroundColor: UIColor?
    var titleColor: UIColor?
    var showNavigationBar: Bool
    
    init(backgroundColor: UIColor?, titleColor: UIColor?,title : String?, displayMode: NavigationBarItem.TitleDisplayMode, showNavigationBar : Bool = true) {
        self.backgroundColor = backgroundColor
        self.showNavigationBar = showNavigationBar
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white]
        coloredAppearance.shadowColor = .clear
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().backgroundColor = .clear
    }
    
    @ViewBuilder
    func body(content: Content) -> some View {
        ZStack{
            if #available(iOS 14, *) {
                 content
                    .navigationTitle(title ?? "")
                    .navigationBarTitleDisplayMode(displayMode)
            }
            else {
                content.navigationBarTitle(title ?? "")
                    .navigationBarTitleDisplayMode(displayMode)
            }
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}
