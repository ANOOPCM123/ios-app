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
import ApolloAPI
import SwiftSoup

extension String{
    func nullable() -> GraphQLNullable<String>{
        return GraphQLNullable.some(self)
    }
}
extension String {
    func stripOutHtml() -> NSAttributedString? {
        do {
           let doc: Document = try SwiftSoup.parse(self)
           return try NSAttributedString(string: doc.text())
        } catch Exception.Error(_, _) {
            return NSAttributedString(string: self)
        } catch {
            return NSAttributedString(string: self)
        }
    }
}
