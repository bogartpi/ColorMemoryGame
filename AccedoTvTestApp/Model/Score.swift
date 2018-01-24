//
//  Score.swift
//  AccedoTvTestApp
//
//  Created by Pavel Bogart on 20/01/2018.
//  Copyright © 2018 Pavel Bogart. All rights reserved.
//

import Foundation
import RealmSwift

class Score: Object {
    @objc dynamic var name = ""
    @objc dynamic var points = 0
    
    convenience init(name: String, points: Int) {
        self.init()
        self.name = name
        self.points = points
    }
    
    /**
     Save an object into database.
     */
    
    func save() {
        let realm = try! Realm()
        try! realm.write {
            realm.add(self)
        }
    }
    
    func delete() {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(self)
        }
    }
    
    /**
     Fetch all objects from database.
     */
    
    class func all() -> Results<Score> {
        let realm = try! Realm()
        return realm.objects(Score.self)
    }

}
