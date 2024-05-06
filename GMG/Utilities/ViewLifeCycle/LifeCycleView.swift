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
import UIKit
import SwiftUI

public struct LifeCycleView: UIViewControllerRepresentable {
    private let viewDidLoad: (() -> Void)?
    private let viewWillAppear: ((Bool) -> Void)?
    private let viewDidAppear: ((Bool) -> Void)?
    private let viewWillDisappear: ((Bool) -> Void)?
    private let viewDidDisappear: ((Bool) -> Void)?
 
    public init(
        viewDidLoad: (() -> Void)? = nil,
        viewWillAppear: ((Bool) -> Void)? = nil,
        viewDidAppear: ((Bool) -> Void)? = nil,
        viewWillDisappear: ((Bool) -> Void)? = nil,
        viewDidDisappear: ((Bool) -> Void)? = nil
    ) {
        self.viewDidLoad = viewDidLoad
        self.viewWillAppear = viewWillAppear
        self.viewDidAppear = viewDidAppear
        self.viewWillDisappear = viewWillDisappear
        self.viewDidDisappear = viewDidDisappear
    }
    public func makeUIViewController(context: Context) -> some UIViewController {
        LifeCycleViewController(
            viewDidLoad: viewDidLoad,
            viewWillAppear: viewWillAppear,
            viewDidAppear: viewDidAppear,
            viewWillDisappear: viewWillDisappear,
            viewDidDisappear: viewDidDisappear
        )
    }
    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
}

public final class LifeCycleViewController: UIViewController {
    private let onViewDidLoad: (() -> Void)?
    private let onViewWillAppear: ((Bool) -> Void)?
    private let onViewDidAppear: ((Bool) -> Void)?
    private let onViewWillDisappear: ((Bool) -> Void)?
    private let onViewDidDisappear: ((Bool) -> Void)?
    
    public init(
        viewDidLoad: (() -> Void)? = nil,
        viewWillAppear: ((Bool) -> Void)? = nil,
        viewDidAppear: ((Bool) -> Void)? = nil,
        viewWillDisappear: ((Bool) -> Void)? = nil,
        viewDidDisappear: ((Bool) -> Void)? = nil
    ) {
        self.onViewDidLoad = viewDidLoad
        self.onViewWillAppear = viewWillAppear
        self.onViewDidAppear = viewDidAppear
        self.onViewWillDisappear = viewWillDisappear
        self.onViewDidDisappear = viewDidDisappear
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        onViewDidLoad?()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onViewWillAppear?(animated)
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        onViewDidAppear?(animated)
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onViewWillDisappear?(animated)
    }
    
    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        onViewDidDisappear?(animated)
    }
}
