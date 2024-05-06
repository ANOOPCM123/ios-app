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

extension Double{
    func trimDoubleValue() -> String{
        let doubleStr = String(format: "%.1f", self)
        return doubleStr
    }
}
