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
struct HomePageItem : Codable, Identifiable {
    let id = UUID()
	let icon : Icon?
	let title : String?
	let action : String?
    let image: Icon?
    let buttonText: String?
    let buttonPosition : String?
    let buttonColor : String?
    let buttontextcolor : String?
    
	enum CodingKeys: String, CodingKey {
		case icon = "icon"
		case title = "title"
		case action = "action"
        case image = "image"
        case buttonText = "buttonText"
        case buttonPosition = "buttonPosition"
        case buttonColor = "buttonColor"
        case buttontextcolor = "buttontextcolor"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		icon = try values.decodeIfPresent(Icon.self, forKey: .icon)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		action = try values.decodeIfPresent(String.self, forKey: .action)
        image = try values.decodeIfPresent(Icon.self, forKey: .image)
        buttonText = try values.decodeIfPresent(String.self, forKey: .buttonText)
        buttonPosition = try values.decodeIfPresent(String.self, forKey: .buttonPosition)
        buttonColor = try values.decodeIfPresent(String.self, forKey: .buttonColor)
        buttontextcolor = try values.decodeIfPresent(String.self, forKey: .buttontextcolor)
	}
}
