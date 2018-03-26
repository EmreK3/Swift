//
//  ViewController.swift
//  LearningSwift
//
//  Created by Emre Kahraman on 25/03/2018.
//  Copyright © 2018 Emre Kahraman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Concentration(numberOfPairs: (cardButtons.count + 1)/2)
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var matchCountLabel: UILabel!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet var exitGame: UIScreenEdgePanGestureRecognizer!
    
    var emojiChoices: [String] = []
    
    func initEmoji() {
        for c in 0x1F601...0x1F64F {
            emojiChoices.append(String(describing: UnicodeScalar(c)!))
        }
    }
    //= ["👾", "👻", "🤖", "🤡", "🎃", "👽", "👹", "💀", "💩", "🐣", ]
    var emoji = [Int:String]()
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var matchCount = 0 {
        didSet {
            let progressPercentage = Float(matchCount*2)/Float(cardButtons.count)
            matchCountLabel.text = "Matches: \(matchCount)"
            
            progressBar.setProgress(progressPercentage, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.setProgress(0, animated: true)
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if emojiChoices.isEmpty {
            initEmoji()
        }
        
        let cardID = cardButtons.index(of: sender)!
        
        if !game.cards[cardID].isMatched, !game.cards[cardID].isFaceUp {
            flipCount += 1
        }
        
        game.chooseCard(at: cardID)
        updateView()
        
        if game.cards[cardID].isMatched {
            matchCount += 1
        }
    }
    
    func updateView() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isMatched {
                button.isEnabled = false
            }
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                if card.isMatched {
                    button.setTitle(emoji(for: card), for: UIControlState.normal)
                }
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.8404037332, green: 0.8404037332, blue: 0.8404037332, alpha: 1)
            }
        }
        if game.isGameOver {
            self.perform(#selector(ViewController.gameOver), with: nil, afterDelay: 3)
        }
    }
    
    @objc func gameOver() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let MainScreenController = storyBoard.instantiateViewController(withIdentifier: "MainScreenController") as! MainScreenController
        
        self.present(MainScreenController, animated: true, completion: nil)
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
}

