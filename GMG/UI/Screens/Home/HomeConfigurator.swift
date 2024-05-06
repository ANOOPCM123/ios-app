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
import Apollo

final class HomeConfigurator {
    public static func configureHomeView(coordinator: HomeCoordinator) -> HomeView {
        let apolloClient = GraphQLSession.shared.apollo
        /// UseCases
        lazy var fetchHomeUseCase: FetchHomeUseCase = {
            FetchHomeUseCaseImpl(repository: HomeRepository(networker: NetworkServiceImpl(apolloClient: apolloClient)))
        }()
        /// Business Logic
        let viewModel : HomeViewModel = HomeViewModel(homeService: fetchHomeUseCase)
        /// View Layer
        let usersView = HomeView(coordinator: coordinator, viewModel: viewModel)
        return usersView
    }
}
