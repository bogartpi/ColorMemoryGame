//
//  Card.swift
//  AccedoTvTestApp
//
//  Created by Pavel Bogart on 19/01/2018.
//  Copyright © 2018 Pavel Bogart. All rights reserved.
//

import Foundation

struct Card {
    var isFacedUp = false
    var isMatched = false
    var identifier: Int
    
    static var idMaker = 0
    
    static func getUniqueID() -> Int {
        idMaker += 1
        return idMaker
    }
    
    init() {
        self.identifier = Card.getUniqueID()
    }
}
