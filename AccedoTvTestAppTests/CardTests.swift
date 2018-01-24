//
//  CardTests.swift
//  AccedoTvTestAppTests
//
//  Created by Pavel Bogart on 24/01/2018.
//  Copyright © 2018 Pavel Bogart. All rights reserved.
//

import XCTest
@testable import AccedoTvTestApp

class CardTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    func testCardInitState() {
        let card = Card()
        
        // Expect card is facedup and ismatched equal to false
        XCTAssertEqual(card.isFacedUp, false)
        XCTAssertEqual(card.isMatched, false)
    }
    
    func test() {
        let card1Id = Card.getUniqueID()
        let card2Id = Card.getUniqueID()
        
        // Expect that each new card get a uniqie Id
        XCTAssertNotEqual(card1Id, card2Id)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
}
