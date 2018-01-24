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
            /* Go through all cards and check if there is only one card that's face up
               If so, return it, else return nil */
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
            // Turn all the cards face down except the card at index newValue
            for index in cards.indices {
                cards[index].isFacedUp = (index == newValue)
            }
        }
    }
    
    func resetItem(at index: Int) {
        cards[index].isFacedUp = false
        cards[index].isMatched = false
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
        
        cards.shuffle()
    }
}
