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
struct Dimensions : Codable {
	let width : Int?
	let aspect_ratio : Double?
	let height : Int?

	enum CodingKeys: String, CodingKey {
		case width = "width"
		case aspect_ratio = "aspect_ratio"
		case height = "height"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		width = try values.decodeIfPresent(Int.self, forKey: .width)
		aspect_ratio = try values.decodeIfPresent(Double.self, forKey: .aspect_ratio)
		height = try values.decodeIfPresent(Int.self, forKey: .height)
	}

}
