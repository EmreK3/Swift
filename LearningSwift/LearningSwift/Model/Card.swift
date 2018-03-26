//
//  Card.swift
//  LearningSwift
//
//  Created by Emre Kahraman on 25/03/2018.
//  Copyright © 2018 Emre Kahraman. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var ID = 0
    
    static func getUniqueID() -> Int {
        ID += 1
        return ID
    }
    
    init() {
        self.identifier = Card.getUniqueID()
    }
}
