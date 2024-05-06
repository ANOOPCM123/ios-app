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
struct HomePageSection : Codable, Identifiable {
    var id = UUID()
    var items : [HomePageItem]?
	let widget_type : String?
    let title : String?
    
	enum CodingKeys: String, CodingKey {
		case items = "items"
		case widget_type = "widget_type"
        case title = "title"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		items = try values.decodeIfPresent([HomePageItem].self, forKey: .items)
		widget_type = try values.decodeIfPresent(String.self, forKey: .widget_type)
        title = try values.decodeIfPresent(String.self, forKey: .title)
	}
}
