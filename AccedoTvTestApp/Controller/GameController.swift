//
//  ViewController.swift
//  AccedoTvTestApp
//
//  Created by Pavel Bogart on 19/01/2018.
//  Copyright © 2018 Pavel Bogart. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    
    lazy var game = Game(numberOfPairsOfCards: (buttonsArray.count + 1) / 2)
    private var openButtonId: Int?
    private var scoreCount: Int = 0 {
        didSet {
            title = String(scoreCount)
        }
    }
    private let cardImageChoices = ["colour1","colour2","colour3","colour4","colour5","colour6","colour7","colour8"]
    private var cardImage = [Int:String]()
    @IBOutlet var buttonsArray: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "0"
    }
    
    @IBAction func cardButtonPressed(_ sender: UIButton) {
        if let buttonIndex = buttonsArray.index(of: sender) {
            game.pickCard(at: buttonIndex)
            let image = UIImage(named: findCardImage(for: game.cards[buttonIndex]))
            sender.setImage(image, for: .normal)
            onButton(cardId: game.cards[buttonIndex])
        }
    }
    
    func onButton(cardId: Card) {
        guard openButtonId != nil else {
            openButtonId = cardId.identifier
            return
        }
        if cardId.identifier == openButtonId {
             Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(matchButtons), userInfo: nil, repeats: false)
        } else {
            openButtonId = nil
             Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideButtons), userInfo: nil, repeats: false)
        }
    }
    
    @objc func matchButtons() {
        scoreCount += 2
        for button in buttonsArray {
            if button.tag == openButtonId {
                button.isUserInteractionEnabled = false
                button.setImage(#imageLiteral(resourceName: "empty_bg"), for: .normal)
            }
        }
        openButtonId = nil
    }
    
    @objc func hideButtons() {
        scoreCount -= 1
        for index in buttonsArray.indices {
            let card = game.cards[index]
            let button = buttonsArray[index]
            if !card.isMatched {
                button.setImage(#imageLiteral(resourceName: "card_bg"), for: .normal)
            }
        }
    }
    
    func findCardImage(for card: Card) -> String {
        if cardImage[card.identifier] == nil, cardImageChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(cardImageChoices.count)))
            cardImage[card.identifier] = cardImageChoices.remove(at: randomIndex)
        }
        return cardImage[card.identifier] ?? "No Image Found"
    }
}

