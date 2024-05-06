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

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @State private var searchText: String = ""
    @State private var opacity: CGFloat = 1.0
    @State private var scrollOffset: CGFloat = .zero
    @State private var titleOffset: CGFloat = 0
    @State private var isShowFulFillments = false
    @State private var isAnimating = false
    @State var currentIndex: Int = 0
    @State private var tabBar: UITabBar! = nil
    @State private var viewAppeared = false
    
    @StateObject public var coordinator: HomeCoordinator
    
    init(coordinator: HomeCoordinator, viewModel: HomeViewModel) {
        _coordinator = StateObject(wrappedValue: coordinator)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            /// Custom App Bar
            CustomTopBarView(
                leftBarItems: HStack {
                    makeAppLogoView()
                },
                rightBarItems: HStack {
                    makeSidemenuIcon()
                },
                leftPadding: 0
            )
            GeometryReader { gr in
                ScrollView(.vertical) {
                    LazyVStack(spacing: 20, content: {
                        ForEach($viewModel.homePageData,  id: \.id) { element in
                            buildListItem(item: element.wrappedValue, proxy: gr)
                        }
                        Spacer()
                    })
                    .background(Color.white)
                }
            }
        }.onAppear(perform: {
            if !viewAppeared{
                viewModel.onAppear()
                viewAppeared = true
            }
        })
    }
    //MARK: Build List Items
    @ViewBuilder
    private func buildListItem(item: HomePageSection, proxy: GeometryProxy)-> some View{
        AnyView(ViewFactory.make(item: item, proxy: proxy,  itemTappedCallback: { item in
            print(item)
        }))
    }
}

#Preview {
    let apolloClient = GraphQLSession.shared.apollo
    /// UseCases
    lazy var fetchHomeUseCase: FetchHomeUseCase = {
        FetchHomeUseCaseImpl(repository: HomeRepository(networker: NetworkServiceImpl(apolloClient: apolloClient)))
    }()
    /// Business Logic
    let viewModel : HomeViewModel = HomeViewModel(homeService: fetchHomeUseCase)
    return HomeView(coordinator: HomeCoordinator(navigationController: UINavigationController()), viewModel: viewModel)
}

