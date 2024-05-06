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
import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case success
        case failed(message: String)
    }
    @Published private(set) var state: State = .idle
    public var homePageData: [HomePageSection] = []
    private var homeService: FetchHomeUseCase
    private var cancellables = Set<AnyCancellable>()
    init(homeService: FetchHomeUseCase) {
        self.homeService = homeService
    }
    //MARK: View appear bussiness logic
    public func onAppear() {
        self.getHomePage()
    }
    //MARK: HomePage API calling
    private func getHomePage() {
        state = .loading
        homeService.call()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.state = .failed(message: error.localizedDescription)
                    print(error)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] home in
                self?.homePageData = home.result?.page_sections ?? []
                self?.state = .success
            }
            .store(in: &cancellables)
    }
}
