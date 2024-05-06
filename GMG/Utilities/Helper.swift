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

class Helper {
    /**
     Splits the given array into multiple arrays with a specified number of columns.
     
     - Parameters:
     - arr: Array of any type
     - columnNumber: Number of columns
     
     - Returns: An array splitted into a given number of columns.
     */
    static func splitData<T>(from arr: [T], into columnNumber: Int = 2) -> [[T]] {
        guard !arr.isEmpty else { return [] }
        let columns = columnNumber > arr.count ? arr.count : columnNumber
        var result = [[T]](repeating: [], count: columns)
        
        for (index, item) in arr.enumerated() {
            let arrayIndex = index % columns
            result[arrayIndex].append(item)
        }
        return result
    }
}
