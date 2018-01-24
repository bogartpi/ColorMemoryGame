//
//  ScoreTests.swift
//  AccedoTvTestAppTests
//
//  Created by Pavel Bogart on 23/01/2018.
//  Copyright © 2018 Pavel Bogart. All rights reserved.
//

import XCTest
@testable import AccedoTvTestApp
import RealmSwift

class ScoreTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Configure a separate database from the real one for testing
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "Testable Database"
    }
    
    func testScoreInit() {
        let score = Score(name: "Jason", points: 20)
        
        // Expect all properties are correctly assigned
        XCTAssertEqual(score.name, "Jason", "Properties assigned incorrectly")
    }
    
    func testSaveObjectToRealm() {
        let score = Score(name: "Mike", points: -12)
        score.save()
        let realm = try! Realm()
        let savedScore = realm.objects(Score.self).last
        
        // Expect to fetch the score with the exact saved name and points
        XCTAssertEqual(savedScore?.name, "Mike", "Name isn't saved into database")
        XCTAssertEqual(savedScore?.points, -12, "Points isn't saved intp database")
    }
    
    func testReadAllSavedObjectsFromRealm() {
        self.createPersons(number: 3)
        let scores = Score.all()
        
        // Expect the returned results to match 3 objects in database
        XCTAssertEqual(scores.count, 3)
        XCTAssertEqual(scores[0].name, "name 0")
        XCTAssertEqual(scores[1].name, "name 1")
        XCTAssertEqual(scores[2].name, "name 2")
    }
    
    func testDeleteObjectFromRealm() {
        self.createPersons(number: 3)
        let scores = Score.all()
        let score1 = scores[1]
        
        score1.delete()
        
        // Expect there are two persons in database: the first and third one
        XCTAssertEqual(scores.count, 2)
        XCTAssertEqual(scores[0].points, 1)
        XCTAssertEqual(scores[1].points, 3)
    }
    
    override func tearDown() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        super.tearDown()
    }
    
    // MARK: - Helper Methods
    
    /**
     Create multiple objects and save them to database for testing
     
     - Parameter number: Number of objects to create and save
     */
    
    func createPersons(number: Int) {
        let realm = try! Realm()
        try! realm.write {
            for i in 0..<number {
                let person = Score(name: "name \(i)", points: 1 + i)
                realm.add(person)
            }
        }
    }
    
}
