//
//  AddFlashcardViewController.swift
//  StudyBuddy
//
//  Created by Godson JEAN on 11/19/25.
//

import UIKit
    
protocol AddFlashcardDelegate: AnyObject {
    func didCreateFlashcard(_ flashcard: Flashcard)
}

class AddFlashcardViewController: UIViewController {

    @IBOutlet weak var questionField: UITextField!
    @IBOutlet weak var answerField: UITextField!

    weak var delegate: AddFlashcardDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Flashcard"
    }

    @IBAction func saveTapped(_ sender: UIButton) {
        guard
            let question = questionField.text, !question.isEmpty,
            let answer = answerField.text, !answer.isEmpty
        else { return }

        let newCard = Flashcard(
            id: Int.random(in: 1000...9999),
            question: question,
            answer: answer,
            tags: []
        )

        delegate?.didCreateFlashcard(newCard)
        navigationController?.popViewController(animated: true)
    }
}
