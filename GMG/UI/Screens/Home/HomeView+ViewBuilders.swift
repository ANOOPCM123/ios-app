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
extension HomeView {
    /// Creating Logo Icon for the top bar
    @ViewBuilder
    func makeAppLogoView()-> some View{
        HStack(alignment: .center, content: {
            ZStack(content: {
                Image(Images.HomePage.logoBackground)
                Image(Images.Global.GMGLogo)
            })
        })
        .onTapGesture {
        }
    }
    /// Creating Sidemenu Icon for the top bar
    @ViewBuilder
    func makeSidemenuIcon()-> some View{
        Rectangle()
            .foregroundColor(.white)
            .background(Color.uiColor(.SecondaryBackgroundColor))
            .frame(width: 38, height: 38)
            .cornerRadius(19)
            .shadow(color: Color.uiColor(.ShadowColor), radius: 6, x: 5, y: 5)
            .overlay(
                Image(Images.HomePage.sidemenu)
                        .aspectRatio(contentMode: .fit)
                        .scaledToFit()
                    
            )
    }
}
