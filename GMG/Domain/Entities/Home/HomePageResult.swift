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
struct HomePageResult : Codable {
	let header : HomeHeader?
	let page_sections : [HomePageSection]?

	enum CodingKeys: String, CodingKey {
		case header = "header"
		case page_sections = "page_sections"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		header = try values.decodeIfPresent(HomeHeader.self, forKey: .header)
		page_sections = try values.decodeIfPresent([HomePageSection].self, forKey: .page_sections)
	}

}
