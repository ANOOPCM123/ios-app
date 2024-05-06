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
import SwiftUI
import SDWebImageSwiftUI

struct BrandActionsHorizontalView: View {
    var proxy: GeometryProxy?
    var title: String?
    @State var actionItems: [HomePageItem] = []
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            if title != nil{
                SectionTitleViewLightBackgorund(title: title ?? "", viewAll: false).padding(.horizontal, 20)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 4) {
                    ForEach(actionItems, id: \.id) { actionItem in
                        BrandActionHorizontalItemView(data: actionItem)
                            .gesture(TapGesture().onEnded({ gesture in
                                
                            }))
                        if actionItem.id != actionItems.last?.id {
                            Spacer()
                        }
                        
                    }
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 20)
            }
        }
        .padding(.top, 8)
    }
}

struct BrandActionHorizontalItemView: View{
    var data: HomePageItem
    var body: some View{
        
        Rectangle()
            .foregroundColor(.white)
            .frame(width: (35-20) * (data.image?.dimensions?.aspect_ratio ?? 3.0) + 32, height: 35)
            .cornerRadius(32)
            .shadow(color: Color.uiColor(.ShadowColor2), radius: 6, x: 5, y: 5)
        
            .overlay(
                WebImage(url: URL(string: data.image?.url ?? ""))
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
                    .padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
            )
    }
}
