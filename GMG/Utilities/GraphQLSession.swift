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

class GraphQLSession {
    static let shared = GraphQLSession()
    private init() {}
    private(set) lazy var apollo = ApolloClient(url: AppEnvironment.apiBaseUrl.appendingPathComponent(AppConstants.APPURL.Routes.CustomerServices))
}
