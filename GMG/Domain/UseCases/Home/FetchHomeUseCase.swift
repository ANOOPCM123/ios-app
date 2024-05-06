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
import Combine

 /// INPUT  PORT FUNCTION
protocol FetchHomeUseCase {
    func call() -> AnyPublisher<HomePageResponse, NetworkError>
}
/// INPUT ADAPATER
struct FetchHomeUseCaseImpl: FetchHomeUseCase {
    var repository: HomeRepositoryProtocol
    func call() -> AnyPublisher<HomePageResponse, NetworkError> {
        repository.fetchHomeData()
    }
}
