//
//  StorageManager.swift
//  My timetable
//
//  Created by Васлий Николаев on 19.02.2020.
//  Copyright © 2020 Васлий Николаев. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static let shared = StorageManager()
    
    func saveObject(_ training: [Training]) {
        
        try! realm.write {
            realm.add(training)
        }
    }
    
    func deleteAll() {
        
        try! realm.write {
            realm.deleteAll()
        }
    }
}
