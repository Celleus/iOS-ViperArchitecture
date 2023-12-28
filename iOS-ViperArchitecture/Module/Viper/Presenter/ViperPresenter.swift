//
//  ViperPresenter.swift
//  iOS-ViperArchitecture
//
//  Created by Celleus on 2023/12/27.
//

import Foundation

protocol ViperPresenterInput {
    // MARK: View Life-Cycle methods

    func viewDidLoad()

    // MARK: Other methods called from View

    func fromView()
}

// MARK: - ViperPresenter

final class ViperPresenter {
    
    // MARK: Architecture properties

    var view: ViperViewInput!
    var interactor: ViperInteractorInput!
    var router: ViperRouterInput!
    
    // MARK: Instance methods

    init(view: ViperViewInput, interactor: ViperInteractorInput, router: ViperRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: Other properties
    
    // MARK: Other methods
    
    func datas() {
        let todos = interactor.fromPresenter()
        view?.fromPresenter(todos)
    }
}

// MARK: - ViperPresenterInput

extension ViperPresenter: ViperPresenterInput {

    func viewDidLoad() {
        datas()
    }
    
    func fromView() {
        datas()
    }
}
