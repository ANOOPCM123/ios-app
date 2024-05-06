//
//  HomeCoordinator.swift
//  GMG
//
//  Created by Jinto Joseph on 02/05/24.
//

import Foundation
import UIKit

// MARK: - HomeCoordinator
class HomeCoordinator: ObservableObject {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func navigateToBrandsView() {
        let viewc = UIViewController()
        viewc.view.backgroundColor = .orange
//        let brandsCoordinator = BrandsCoordinator(navigationController: navigationController!)
//        let brandsView = BrandsView2(coordinator: brandsCoordinator)
//        navigationController?.pushViewController(UIHostingController(rootView: brandsView), animated: true)
    }
}
