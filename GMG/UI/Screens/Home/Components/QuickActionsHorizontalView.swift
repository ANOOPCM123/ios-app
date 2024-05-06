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

import SwiftUI
import SDWebImageSwiftUI

struct QuickActionsHorizontalView: View {
    var proxy: GeometryProxy?
    @State var actionItems: [HomePageItem] = []
    var itemTappedCallback: (HomePageItem) -> Void // Callback closure
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    
    var body: some View {
        let rows = actionItems.chunked(into: 4)
        VStack(alignment: .center, spacing: 16) {
            ForEach(rows.indices, id: \.self) { rowIndex in
                HStack {
                    ForEach(rows[rowIndex]) { item in
                        QuickActionHorizontalItemView(data: item)
                            .frame(width: calculateItemWidth(for: rows[rowIndex].count))
                            .onTapGesture {
                                itemTappedCallback(item)
                            }
                    }
                    // If this is the last row and it has fewer items, add spacers on both sides
                    if rowIndex == rows.count - 1 && rows[rowIndex].count < 4 {
                        Spacer()
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
    
    private func calculateItemWidth(for itemCount: Int) -> CGFloat {
        let totalSpacing = 16 * CGFloat(itemCount - 1)
        let availableWidth = proxy!.size.width - totalSpacing - (2 * 16) // Subtracting the padding on both sides
        return availableWidth / CGFloat(itemCount)
    }
}

struct QuickActionHorizontalItemView: View {
    var data: HomePageItem
    var body: some View {
        VStack(spacing: 8) {
            WebImage(url: URL(string: data.icon?.url ?? ""))
                .resizable()
                .frame(width: 26, height: 26)
                .clipped()
                .aspectRatio(contentMode: .fill)
                .scaledToFit()
            Text(data.title ?? "")
                .font(.custom(FontType.Poppins.name, size: 13))
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, 2) // Adjust padding as needed
                .frame(height: 32)
        }
    }
}
// Helper extension to chunk the array into rows
extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
