//
//  Concentration.swift
//  LearningSwift
//
//  Created by Emre Kahraman on 25/03/2018.
//  Copyright © 2018 Emre Kahraman. All rights reserved.
//

import Foundation
import GameplayKit

class Concentration {
    var cards = [Card]()
    var matchedCards = [Card]()
    var indexOfOnlyFaceUpCard: Int?
    var isGameOver = false
    
    init(numberOfPairs: Int) {
        for _ in 0..<numberOfPairs {
            let card = Card()
            cards += [card,card]
        }
        cards = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: cards) as! [Card]
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched, let matchIndex = indexOfOnlyFaceUpCard, matchIndex != index {
            // check if cards match
            if cards[matchIndex].identifier == cards[index].identifier {
                cards[matchIndex].isMatched = true
                cards[index].isMatched = true
                matchedCards += [cards[matchIndex], cards[index]]
            }
            cards[index].isFaceUp = true
            indexOfOnlyFaceUpCard = nil
        } else {
            // either no cards or two cards are face up
            for flipDownIndex in cards.indices {
                cards[flipDownIndex].isFaceUp = false
            }
            cards[index].isFaceUp = true
            indexOfOnlyFaceUpCard = index
        }
        checkGameStatus()
    }
    
    func checkGameStatus() {
        if matchedCards.count == cards.count {
            isGameOver = true
        }
    }
}
