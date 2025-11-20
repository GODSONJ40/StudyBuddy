//
//  FlashcardDetailViewController.swift
//  StudyBuddy
//
//  Created by Godson JEAN on 11/07/25.
//

import UIKit

protocol FlashcardDelegate: AnyObject {
    func flashcardDidComplete(_ flashcard: Flashcard, correct: Bool)
}

class FlashcardDetailViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!

    var flashcard: Flashcard!
    weak var delegate: FlashcardDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Flashcard"
        
        if let card = flashcard {
            questionLabel.text = flashcard.question
            answerLabel.text = "Tap Reveal"
        } else {
            questionLabel.text = "No flashcard loaded"
            answerLabel.text = ""
        }
//        questionLabel.text = flashcard.question
//        answerLabel.text = "Tap Reveal"        if let card = flashcard

    }

    @IBAction func revealTapped(_ sender: UIButton) {
        answerLabel.text = flashcard.answer
    }

    @IBAction func markCorrect(_ sender: UIButton) {
        delegate?.flashcardDidComplete(flashcard, correct: true)
        navigationController?.popViewController(animated: true)
    }

    @IBAction func markIncorrect(_ sender: UIButton) {
        delegate?.flashcardDidComplete(flashcard, correct: false)
        navigationController?.popViewController(animated: true)
    }
}
