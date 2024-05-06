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
struct HomeHeader : Codable {
	let logo : Icon?
	let title : String?
	let message : String?

	enum CodingKeys: String, CodingKey {
		case logo = "logo"
		case title = "title"
		case message = "message"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		logo = try values.decodeIfPresent(Icon.self, forKey: .logo)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		message = try values.decodeIfPresent(String.self, forKey: .message)
	}

}
