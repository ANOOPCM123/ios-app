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
import SwiftUI
/// OUTPUT ADAPTER
class HomeRepository: HomeRepositoryProtocol{
    let networker: NetworkService
    init(networker: NetworkService) {
        self.networker = networker
    }
    //MARK: Fetch HomePage Data
    func fetchHomeData() -> AnyPublisher<HomePageResponse, NetworkError> {
        let queryService = QueryService()
        let language = "en"
        let formattedQuery = queryService.createMainHomeQuery(language: language)
        let encodedMinimalQuery = encodeQuery(formattedQuery)
        let baseUrl = AppEnvironment.apiBaseUrl.absoluteString
        let urlString = "\(baseUrl)?query=\(encodedMinimalQuery)"
        let restRequest = RESTRequest<HomePageResponse>(url: URL(string: urlString)!)
        return networker.performRESTRequest(request: restRequest).eraseToAnyPublisher()
    }
    func encodeQuery(_ query: String) -> String {
        return  query.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!
    }
}



