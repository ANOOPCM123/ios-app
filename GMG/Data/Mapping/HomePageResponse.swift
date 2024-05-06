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
struct HomePageResponse : Codable {
	let query : String?
	let result : HomePageResult?

	enum CodingKeys: String, CodingKey {
		case query = "query"
		case result = "result"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		query = try values.decodeIfPresent(String.self, forKey: .query)
		result = try values.decodeIfPresent(HomePageResult.self, forKey: .result)
	}

}
