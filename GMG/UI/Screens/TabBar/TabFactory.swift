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

enum TabItemType {
    case home
    case offers
    case brands
    case notifications
    case profile
}

struct TabItemFactory {
    static func makeTabItem(for type: TabItemType) -> UITabBarItem {
        switch type {
        case .home:
            return UITabBarItem(title: Strings.TabBar.home, image: UIImage(named: Images.TabBar.homeNormal), tag: 0)
        case .offers:
            return UITabBarItem(title: Strings.TabBar.offers, image: UIImage(named: Images.TabBar.offersNormal), tag: 1)
        case .brands:
            return UITabBarItem(title: Strings.TabBar.brands, image: UIImage(named: Images.TabBar.brandsNormal), tag: 2)
        case .notifications:
            return UITabBarItem(title: Strings.TabBar.notifications, image: UIImage(named: Images.TabBar.notificationsNormal), tag: 3)
        case .profile:
            return UITabBarItem(title: Strings.TabBar.profile, image: UIImage(named: Images.TabBar.profileNormal), tag: 4)
        }
    }
    // Function to create a view controller for a tab bar item type
    static  func makeTabBarViewController(for type: TabItemType) -> UIViewController {
        let rootView: AnyView
        let navigationController = UINavigationController()
        switch type {
        case .home:
            var homeCoordinator: HomeCoordinator?
            homeCoordinator = HomeCoordinator(navigationController: navigationController)
            homeCoordinator?.navigationController = navigationController
            rootView = AnyView(HomeConfigurator.configureHomeView(coordinator: homeCoordinator!))
        case .offers:
            rootView = AnyView(OffersView()) // Assuming OffersView is a SwiftUI view
        case .brands:
            rootView = AnyView(BrandsView())
        case .notifications:
            rootView = AnyView(NotificationsView())
        case .profile:
            rootView = AnyView(ProfileView())
        }
        let hostingController = UIHostingController(rootView: rootView)
        hostingController.tabBarItem = TabItemFactory.makeTabItem(for: type)
        hostingController.navigationItem.hidesBackButton = true // Hide back button for all tabs
        navigationController.viewControllers = [hostingController]
        navigationController.navigationBar.isHidden = true
        return navigationController
    }
}
