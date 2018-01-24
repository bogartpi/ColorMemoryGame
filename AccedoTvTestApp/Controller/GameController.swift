//
//  ViewController.swift
//  AccedoTvTestApp
//
//  Created by Pavel Bogart on 19/01/2018.
//  Copyright © 2018 Pavel Bogart. All rights reserved.
//

import UIKit
import RealmSwift

class GameController: BaseGameController {
    
    // MARK: - Properties
    
    private var realm: Realm!
    private var scores = Score.all()
    private lazy var game = Game(numberOfPairsOfCards: (buttonsArray.count + 1) / 2)
    private var openCardId: Int?
    private var cardImageChoices = ["colour1", "colour2", "colour3", "colour4",
                                    "colour5", "colour6", "colour7", "colour8"]
    private var cardImage = [Int: String]()
    private var countMatchedPairs = 0
    private var scoreCount: Int = 0 {
        didSet {
            title = String(scoreCount)
        }
    }
    
    // MARK: - IBOutlet
    
    @IBOutlet var buttonsArray: [UIButton]!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        restartGame()
        
    }
    
    // MARK: - IBActions
    
    @IBAction func cardButtonPressed(_ sender: UIButton) {
        if let buttonIndex = buttonsArray.index(of: sender) {
            game.pickCard(at: buttonIndex)
            let image = UIImage(named: findCardImage(for: game.cards[buttonIndex]))
            sender.setImage(image, for: .normal)
            onButton(card: game.cards[buttonIndex], button: buttonsArray[buttonIndex])
            if game.cards[buttonIndex].isFacedUp == true {
                sender.isUserInteractionEnabled = false
                sender.pulsate()
            }
        }
    }
    
    override func colourmemoryLogoPressed(_ sender: Any) {
        self.restartGame()
    }
    
    override func highScoreButtonPressed(_ sender: Any) {
        let navController = UINavigationController(rootViewController: HighScoreController())
        navController.modalTransitionStyle = .crossDissolve
        self.present(navController, animated: true, completion: nil)
    }
    
    // MARK: - Functions
    
    /**
     Takes in a card as a parameter, removes the image from
     cardImageChoices array with corresponding index
     and returns that image for the card identifier
     
     - Parameter card: The object of struct Card.
     - Returns: The image from array of images.
     */
    private func findCardImage(for card: Card) -> String {
        if cardImage[card.identifier] == nil, cardImageChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(cardImageChoices.count)))
            cardImage[card.identifier] = cardImageChoices.remove(at: randomIndex)
        }
        return cardImage[card.identifier] ?? "No Image Found"
    }
    
    /**
     When pressed on button it takes a card from cards array
     with corresponding button index, check if there is a match of two card pairs,
     or flip cards down if there is no match
     
     - Parameter card: The object of struct Card.
     */
    private func onButton(card: Card, button: UIButton) {
        guard openCardId != nil else {
            openCardId = card.identifier
            return
        }
        self.view.isUserInteractionEnabled = false
        if card.identifier == openCardId {
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(matchButtons), userInfo: nil, repeats: false)
        } else {
            Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(hideButtons), userInfo: nil, repeats: false)
        }
    }

    // MARK: - Handle Card States
    
    /**
     Handle matched cards and add 2 points matching
     */
    @objc private func matchButtons() {
        scoreCount += 2
        for button in buttonsArray {
            if button.tag == openCardId {
                button.isUserInteractionEnabled = false
                button.setImage(#imageLiteral(resourceName: "empty_bg"), for: .normal)
                countMatchedPairs += 1
                if countMatchedPairs == 16 {
                    finishGame()
                }
            }
        }
        view.isUserInteractionEnabled = true
        openCardId = nil
    }
    
    /**
     Handle unmatched buttons and decrease a score by 1 point for an unmatched pair
     */
    @objc private func hideButtons() {
        scoreCount -= 1
        for index in buttonsArray.indices {
            let card = game.cards[index]
            let button = buttonsArray[index]
            if !card.isMatched {
                button.setImage(#imageLiteral(resourceName: "card_bg"), for: .normal)
                button.isUserInteractionEnabled = true
            }
        }
        self.view.isUserInteractionEnabled = true
        openCardId = nil
    }
    
    // MARK: - Reset Game
    
    /**
     Reset required properties to update the board, shuffle buttons and set all cards to unmatched state
     */
    @objc private func restartGame() {
        resetGameValues()
        buttonsArray.shuffle()
        resetBoardView()
        for (index, card) in game.cards.enumerated() {
            buttonsArray[index].tag = card.identifier
            game.resetItem(at: index)
        }
    }
    
    /**
     Reset game properties to its initial state
    */
    private func resetGameValues() {
        cardImageChoices = ["colour1","colour2","colour3","colour4",
                            "colour5","colour6","colour7","colour8"]
        scoreCount = 0
        countMatchedPairs = 0
        openCardId = nil
        cardImage.removeAll()
    }
    
    /**
     Reset buttons view to its initial state
     */
    private func resetBoardView() {
        for button in buttonsArray {
            button.setImage(#imageLiteral(resourceName: "card_bg"), for: .normal)
            button.isUserInteractionEnabled = true
        }
    }
    
    /**
     When all cards are matched a popup with input of username appears
     to save the score into database. When action Save or Cancel are triggered
     the game will be reset
     */
    private func finishGame() {
        let alertVC = UIAlertController(title: "Well Done! You spotted all cards!", message: "Your score: \(scoreCount)!", preferredStyle: .alert)
        alertVC.addTextField(configurationHandler: { (textField) in textField.placeholder = "Enter Name" })
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: { [weak self] (action) in
            self?.restartGame()
        })
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { [unowned self] (action) in
            let nameTextField = (alertVC.textFields?.first)! as UITextField
            guard let rawString = nameTextField.text else { return }
            let nameString = rawString.replacingOccurrences(of: " ", with: "")
            
            let score = Score(name: nameString, points: self.scoreCount)
            score.save()
            
            self.restartGame()
        })
        alertVC.addAction(saveAction)
        alertVC.addAction(cancelAction)
        self.present(alertVC, animated: true, completion: nil)
    }

}

