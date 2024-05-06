//
// Copyright © 2023 Singleton Commerce.
//
// All rights reserved.
//
// This software is the confidential and proprietary information of Singleton Commerce ("Confidential Information"). You
// shall not disclose such Confidential Information and shall use it only in accordance with the terms of the contract
// agreement you entered into with Singleton Commerce.

// @author Jinto Joseph on 04/12/23


import Foundation
import SwiftUI

struct AttributedTextView: UIViewRepresentable {
    let attributedText: NSAttributedString
    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }
    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.attributedText = attributedText
    }
}
