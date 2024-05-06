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
import UIKit
import SwiftUI
import Apollo

// MARK: - DashboardTabBarController
class GMGTabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        // Create view controllers for each tab bar item type
        let views = [
            TabItemFactory.makeTabBarViewController(for: .home),
            TabItemFactory.makeTabBarViewController(for: .offers),
            TabItemFactory.makeTabBarViewController(for: .brands),
            TabItemFactory.makeTabBarViewController(for: .notifications),
            TabItemFactory.makeTabBarViewController(for: .profile)
        ]
        // Set the view controllers for the tab bar
        viewControllers = views
    }
    // Optional: Implement UITabBarControllerDelegate methods if needed
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "")")
        return true
    }
}
