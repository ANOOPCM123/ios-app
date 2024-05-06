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

struct KeyConstants {
    enum HomeViewWidgets : String {
        case actionList = "action_list"
        case navigationList = "navigation_list"
    }
}

struct AppConstants {
    //Account
    enum Account : String {
        case customerId
        case isNewCustomerRegistered
        case isWelcomePageViewed
        case isUserLoggedIn
    }
    //URLConstants.swift
    struct APPURL {
        struct Domains {
            static let DEV = "https://singleton.api.dev.singletoncommercecloud.com"
            static let QA = "https://singleton.api.qa.singletoncommercecloud.com"
        }
        struct Routes {
            static let CustomerServices = "/commerce-catalog-services"
        }
    }
}
//Location Permission Errors
enum LocationErrors: String {
    case denied = "Locations are turned off. Please turn it on in Settings"
    case restricted = "Locations are restricted"
    case notDetermined = "Locations are not determined yet"
    case notFetched = "Unable to fetch location"
    case invalidLocation = "Invalid Location"
    case reverseGeocodingFailed = "Reverse Geocoding Failed"
    case unknown = "Some Unknown Error occurred"
}
