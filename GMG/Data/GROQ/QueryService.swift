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

class QueryService {
    func createMainHomeQuery(language: String) -> String {
        return """
            *[_type == "main_home" && language == "\(language)" && !(_id in path('drafts.**'))][0]{
                header->{
                    "logo": logo.asset ->{
                        mimeType,
                        "dimensions":{
                            "width": metadata.dimensions.width,
                            "aspect_ratio": metadata.dimensions.aspectRatio,
                            "height": metadata.dimensions.height
                        },
                        url,
                    },
                    title,
                    message,
                },
                "page_sections": page_sections.contents[]{
                    _type == "action_list" =>{
                        "items": actions[]{
                            "icon": icon.asset ->{
                                mimeType,
                                "dimensions":{
                                    "width": metadata.dimensions.width,
                                    "aspect_ratio": metadata.dimensions.aspectRatio,
                                    "height": metadata.dimensions.height
                                },
                                url,
                            },
                            title,
                            action,
                        },
                        "widget_type":_type,
                    },
                    _type == "navigation_list" =>{
                        "items": brands.brands[]->{
                            "navigateTo": navigateTo->site->{
                                "slug": slug.current,
                                "id": _id
                            },
                            title,
                            "image": image.asset->{
                                mimeType,
                                "dimensions":{
                                    "width": metadata.dimensions.width,
                                    "aspect_ratio": metadata.dimensions.aspectRatio,
                                    "height": metadata.dimensions.height
                                },
                                url,
                            }
                        },
                        "title": brands.title,
                        "widget_type":_type,
                    },
                },
            }
        """
    }
}
