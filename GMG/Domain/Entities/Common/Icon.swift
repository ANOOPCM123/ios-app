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
struct Icon : Codable {
	let mimeType : String?
	let dimensions : Dimensions?
	let url : String?

	enum CodingKeys: String, CodingKey {
		case mimeType = "mimeType"
		case dimensions = "dimensions"
		case url = "url"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		mimeType = try values.decodeIfPresent(String.self, forKey: .mimeType)
		dimensions = try values.decodeIfPresent(Dimensions.self, forKey: .dimensions)
		url = try values.decodeIfPresent(String.self, forKey: .url)
	}
}
