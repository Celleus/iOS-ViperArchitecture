//
//  ViperRepository.swift
//  iOS-ViperArchitecture
//
//  Created by Celleus on 2023/12/28.
//

import Foundation

// MARK: - ViperRepositoryInterface

protocol ViperRepositoryInterface {
    func getDatas() -> [Todo]
    func addTodo(_ title: String)
}

// MARK: - ViperRepository

final class ViperRepository: ViperRepositoryInterface {
    
    // MARK: Instance properties

    let isDelete: Bool
    
    // MARK: Instance methods

    init(_ isDelete: Bool = false) {
        self.isDelete = isDelete
    }

    // MARK: Other properties
    
    // MARK: Other methods
    
    func getDatas() -> [Todo] {
        return Todo.all(isDelete)
    }
    
    func addTodo(_ title: String) {
        var todo = Todo()
        todo.title = title
        todo.create()
    }
}
