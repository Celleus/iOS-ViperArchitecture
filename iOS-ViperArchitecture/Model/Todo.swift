//
//  Todo.swift
//  iOS-ViperArchitecture
//
//  Created by Celleus on 2023/12/28.
//

import Foundation
import RealmSwift

class Todo: Object {

    // ID（自動採番）
    @objc dynamic var id = 0
    
    // タイトル
    @objc dynamic var title = ""
    
    // 作成日時など
    @objc dynamic var createDate = Date()
    @objc dynamic var updateDate = Date()
    @objc dynamic var deleteDate = Date()
    @objc dynamic var deleteFlag = false
    
    // MARK: PrimaryKey
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // MARK: Internal methods
    
    private func createNewId() -> Int {
        let realm = try! Realm()
        return (realm.objects(type(of: self).self).sorted(byKeyPath: "id", ascending: false).first?.id ?? 0) + 1
    }
    
    // MARK: Create methods
    
    func create() {
        let realm = try! Realm()
        if realm.isInWriteTransaction {
            if self.id == 0 { self.id = self.createNewId() }
            realm.add(self, update: .all)
        } else {
            try! realm.write {
                if self.id == 0 { self.id = self.createNewId() }
                realm.add(self, update: .all)
            }
        }
    }
    
    // MARK: Update methods
    
    func update( title: String) -> Bool {
        let realm = try! Realm()
        do{
            try realm.write{
                self.title = title
                self.updateDate = Date()
            }
            return true
        }
        catch {
            print("error:\(error)")
            return false
        }
    }
    
    // MARK: Delete methods
    
    func delete() -> Bool {
        let realm = try! Realm()
        do{
            try realm.write{
                self.deleteFlag = true
                self.deleteDate = Date()
            }
            return true
        }
        catch {
            print("error:\(error)")
            return false
        }
    }

    // MARK: Get methods
    
    static func all() -> [Todo] {
        return Array( all(false) );
    }
    
    static func all(_ deleteFlag: Bool) -> [Todo] {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "deleteFlag == %@", argumentArray: [deleteFlag])
        let results = realm.objects(Todo.self).filter(predicate).sorted(byKeyPath: "createDate", ascending: true)
        let array : [Todo] = Array(results)
        return array;
    }
}
