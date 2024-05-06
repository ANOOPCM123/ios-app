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

/// Case-less enum used as a namespace.
public enum AppEnvironment {
    
    /// a enum to centralize all keys
    private enum Keys: String {
        case apiBaseUrl = "API_BASE_URL"
    }
    
    /// If cannot find Info.plist, simply crash as it is a developer error and should never happen
    private static let infoDictionary: [String: Any] = Bundle.main.infoDictionary!
    
    static let apiBaseUrl: URL = .init(string: infoDictionary[Keys.apiBaseUrl.rawValue] as! String)!
}
