//
// Copyright © 2023 Singleton Commerce.
//
// All rights reserved.
//
// This software is the confidential and proprietary information of Singleton Commerce ("Confidential Information"). You
// shall not disclose such Confidential Information and shall use it only in accordance with the terms of the contract
// agreement you entered into with Singleton Commerce.

// @author Jinto Joseph on 04/12/23

import Foundation
import UIKit
import SwiftUI
// Helper bridge to UIViewController to access enclosing UITabBarController
// and thus its UITabBar
struct TabBarAccessor: UIViewControllerRepresentable {
    var callback: (UITabBar, Bool) -> Void
    private let proxyController = ViewController()

    func makeUIViewController(context: UIViewControllerRepresentableContext<TabBarAccessor>) ->
                              UIViewController {
        proxyController.callback = callback
        return proxyController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<TabBarAccessor>) {
    }
    
    typealias UIViewControllerType = UIViewController

    private class ViewController: UIViewController {
        var callback: (UITabBar, Bool) -> Void = { _,_  in }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if let tabBar = self.tabBarController {
                self.callback(tabBar.tabBar, true)
            }
        }
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            if let tabBar = self.tabBarController {
                self.callback(tabBar.tabBar, false)
            }
        }
//        override func viewDidDisappear(_ animated: Bool) {
//            super.viewDidDisappear(animated)
//            if let tabBar = self.tabBarController {
//                self.callback(tabBar.tabBar, false)
//            }
//        }
    }
}
