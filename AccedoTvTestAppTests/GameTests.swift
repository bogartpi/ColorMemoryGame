//
//  AccedoTvTestAppTests.swift
//  AccedoTvTestAppTests
//
//  Created by Pavel Bogart on 23/01/2018.
//  Copyright © 2018 Pavel Bogart. All rights reserved.
//

import XCTest
@testable import AccedoTvTestApp

class GameTests: XCTestCase {
    
    var gameUnderTest: Game!
    
    override func setUp() {
        super.setUp()
        gameUnderTest = Game(numberOfPairsOfCards: 4)
    }
    
    func testReturnAllCardsOnBoard() {
        let cardsArray = gameUnderTest.cards
        
        // Expect that the number of initialized cards equal to 8 cards
        XCTAssertEqual(cardsArray.count, 8, "Game returns wrong number of cards")
    }
    
    func testInitialCardState() {
        let cardsArray = gameUnderTest.cards
        
        // Expect that all cards in array have been initialized with correct card state
        for card in cardsArray {
            XCTAssertEqual(card.isMatched, false, "Initial card state is wrong")
            XCTAssertEqual(card.isFacedUp, false, "Initial card state is wrong")
            XCTAssertNotEqual(card.identifier, nil)
        }
    }
    
    override func tearDown() {
        gameUnderTest = nil
        super.tearDown()
    }
    
}
