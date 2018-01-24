//
//  AccedoTvTestAppTests.swift
//  AccedoTvTestAppTests
//
//  Created by Pavel Bogart on 23/01/2018.
//  Copyright © 2018 Pavel Bogart. All rights reserved.
//

import XCTest
@testable import AccedoTvTestApp

class AccedoTvTestAppTests: XCTestCase {
    
    var gameUnderTest: Game!
    
    override func setUp() {
        super.setUp()
        gameUnderTest = Game(numberOfPairsOfCards: 8)
    }
    
    func testReturnAllCardsOnBoard() {
        let cardsArray = gameUnderTest.cards
        XCTAssertEqual(cardsArray.count, 16, "Game returns wrong number of cards")
    }
    
    func testInitialCardState() {
        let cardsArray = gameUnderTest.cards
        for card in cardsArray {
            XCTAssertEqual(card.isMatched, false, "Initial card state is wrong")
            XCTAssertEqual(card.isFacedUp, false, "Initial card state is wrong")
        }
    }
    
    override func tearDown() {
        gameUnderTest = nil
        super.tearDown()
    }
    
}
