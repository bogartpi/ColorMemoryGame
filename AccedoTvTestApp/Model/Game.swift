//
//  Game.swift
//  AccedoTvTestApp
//
//  Created by Pavel Bogart on 19/01/2018.
//  Copyright © 2018 Pavel Bogart. All rights reserved.
//

import Foundation

class Game {
    
    var cards = [Card]()
    
    var whenOneCardIsFaceUpIndex: Int? {
        get {
            //Look at the all cards and see if you find only one that's face up
            //If so, return it, else return nil
            var matchIndex: Int?
            for index in cards.indices {
                if cards[index].isFacedUp {
                    if matchIndex == nil {
                        matchIndex = index
                    } else {
                        matchIndex = nil
                    }
                }
            }
            return matchIndex
        }
        
        set {
            //Turn all the cards face down except the card at index newValue
            for index in cards.indices {
                cards[index].isFacedUp = (index == newValue)
            }
        }
    }
    
    func pickCard(at index: Int) {
        if !cards[index].isMatched {
            if let indexToMatch = whenOneCardIsFaceUpIndex, indexToMatch != index {
                // check if cards match
                if cards[indexToMatch].identifier == cards[index].identifier {
                    cards[indexToMatch].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFacedUp = true
            } else {
                whenOneCardIsFaceUpIndex = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // TODO: Shuffle the cards
    }
}
