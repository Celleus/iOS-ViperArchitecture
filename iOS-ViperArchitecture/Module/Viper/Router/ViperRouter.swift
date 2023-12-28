//
//  ViperRouter.swift
//  iOS-ViperArchitecture
//
//  Created by Celleus on 2023/12/27.
//

import Foundation
import UIKit

@MainActor
protocol ViperRouterInput: AnyObject {
    // MARK: View transitions
    func presentViewController()
}

// MARK: - ViperRouter

@MainActor
final class ViperRouter {
    
    // MARK: Architecture properties
    
    private unowned let viewController: ViperViewController
    
    // MARK: Instance methods

    init(viewController: ViperViewController) {
        self.viewController = viewController
    }

    // MARK: Other properties
    
    // MARK: Other methods
}

// MARK: - Assemble

extension ViperRouter {
    static func assembleModule(_ repository: ViperRepository) -> ViperViewController {
        let view = UIStoryboard(name: "ViperViewController", bundle: nil).instantiateInitialViewController() as! ViperViewController
        let interactor = ViperInteractor(repository: repository)
        let router = ViperRouter(viewController: view)
        let presenter = ViperPresenter(view: view, interactor: interactor, router: router)

        view.presenter = presenter

        return view
    }
}

// MARK: - ViperRouterInput

extension ViperRouter: ViperRouterInput {
    func presentViewController() {}
}
