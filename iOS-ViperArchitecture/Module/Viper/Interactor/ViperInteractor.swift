//
//  ViperIneractor.swift
//  iOS-ViperArchitecture
//
//  Created by Celleus on 2023/12/27.
//

import Foundation

protocol ViperInteractorInput {
    // MARK: Methods called from presenter
    func fromPresenter() -> [Todo]
    func createTodo(_ title: String)
}

// MARK: - ViperInteractor

final class ViperInteractor {
    
    // MARK: Architecture properties
    
    private var repository: ViperRepositoryInterface

    // MARK: Instance methods

    init(repository: ViperRepository) {
        self.repository = repository
    }

    // MARK: Other properties
    
    // MARK: Other methods
}

// MARK: - ViperInteractorInput

extension ViperInteractor: ViperInteractorInput {
    
    func fromPresenter() -> [Todo] {
        return repository.getDatas()
    }
    
    func createTodo(_ title: String) {
        repository.addTodo(title)
    }
    
}
