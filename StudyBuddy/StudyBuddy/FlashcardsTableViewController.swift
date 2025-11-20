//
//  FlashcardsTableViewController.swift
//  StudyBuddy
//
//  Created by Godson JEAN on 11/07/25.
//

import UIKit

class FlashcardsTableViewController: UITableViewController, AddFlashcardDelegate {

    private var flashcards: [Flashcard] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Flashcards"
        loadMockFlashcards()
    }

    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        // handled via storyboard segue
    }

    // MARK: - AddFlashcardDelegate
    func didCreateFlashcard(_ flashcard: Flashcard) {
        flashcards.append(flashcard)
        tableView.reloadData()
    }

    // MARK: - Load Mock Data
    func loadMockFlashcards() {
        flashcards = [
            Flashcard(id: 1,
                      question: "Who is the best iOS Vibe-coding instructor?",
                      answer: "Sir Andros Slowley",
                      tags: ["ios","architecture"]),
            Flashcard(id: 2,
                      question: "What is Codable used for?",
                      answer: "Encoding & decoding model types",
                      tags: ["encoding"]),
            Flashcard(id: 3, question: "What is UserDefaults good for?", answer: "Small local data persistence", tags: ["persistence"]),
            Flashcard(id: 4, question: "What is UNC Charlotte’s mascot?", answer: "Norm the Niner", tags: ["uncc","charlotte"]),
            Flashcard(id: 5, question: "What year was UNC Charlotte founded?", answer: "1946", tags: ["uncc","history"]),
            Flashcard(id: 6, question: "What is the name of UNC Charlotte’s football stadium?", answer: "Richardson Stadium", tags: ["uncc","sports"]),
            Flashcard(id: 7, question: "What does CPU stand for?", answer: "Central Processing Unit", tags: ["computing","hardware"]),
            Flashcard(id: 8, question: "What is Big O used to measure?", answer: "Algorithm time and space complexity", tags: ["dsa","complexity"]),
            Flashcard(id: 9, question: "What is a boolean?", answer: "A variable type with values true or false", tags: ["fundamentals"]),
            Flashcard(id: 10, question: "What is the largest country by land area?", answer: "Russia", tags: ["countries","geography"]),
            Flashcard(id: 11, question: "Which country has the most islands?", answer: "Sweden", tags: ["countries","facts"]),
            Flashcard(id: 12, question: "Which country is known as the Land of the Rising Sun?", answer: "Japan", tags: ["countries","culture"]),
            Flashcard(id: 13, question: "What is the capital of Haiti?", answer: "Port-au-Prince", tags: ["caribbean","haiti"]),
            Flashcard(id: 14, question: "Which Caribbean island is known for reggae music?", answer: "Jamaica", tags: ["caribbean","music"]),
            Flashcard(id: 15, question: "What is the official language of the Dominican Republic?", answer: "Spanish", tags: ["caribbean","language"]),
            Flashcard(id: 16, question: "How many players are on a basketball team on the court?", answer: "Five per team", tags: ["sports","basketball"]),
            Flashcard(id: 17, question: "What sport uses a shuttlecock?", answer: "Badminton", tags: ["sports","facts"]),
            Flashcard(id: 18, question: "What is the world’s most-watched sporting event?", answer: "FIFA World Cup", tags: ["sports","world"]),
            Flashcard(id: 19, question: "What is sushi traditionally wrapped in?", answer: "Seaweed", tags: ["food","culture"]),
            Flashcard(id: 20, question: "Which country invented pizza?", answer: "Italy", tags: ["food","history"]),
            Flashcard(id: 21, question: "What fruit is the main ingredient in guacamole?", answer: "Avocado", tags: ["food","ingredients"]),
            Flashcard(id: 22, question: "Who is the founder of Microsoft?", answer: "Bill Gates", tags: ["tech","history"]),
            Flashcard(id: 23, question: "What does AWS stand for?", answer: "Amazon Web Services", tags: ["tech","cloud"]),
            Flashcard(id: 24, question: "Which company owns Android?", answer: "Google", tags: ["tech","mobile"]),
            Flashcard(id: 25, question: "What is the busiest airport in the world?", answer: "Hartsfield–Jackson Atlanta International Airport", tags: ["travel","airports"]),
            Flashcard(id: 26, question: "What is a common New Year’s resolution?", answer: "Exercise more", tags: ["newyear","goals"]),
            Flashcard(id: 27, question: "What travel item must match your plane ticket name?", answer: "Your passport", tags: ["travel","tips"])
        ]
        tableView.reloadData()
    }

    // MARK: - TableView Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        flashcards.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlashcardCell", for: indexPath)
        let card = flashcards[indexPath.row]
        cell.textLabel?.text = card.question
        cell.detailTextLabel?.text = card.tags?.joined(separator: ", ")
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // ADD FLASHCARD
        if segue.identifier == "AddFlashcard",
           let dest = segue.destination as? AddFlashcardViewController {
            dest.delegate = self
        }

        // SHOW FLASHCARD DETAIL
        if segue.identifier == "ShowFlashcardDetail" {

            let destinationVC: FlashcardDetailViewController?

            if let nav = segue.destination as? UINavigationController {
                destinationVC = nav.topViewController as? FlashcardDetailViewController
            } else {
                destinationVC = segue.destination as? FlashcardDetailViewController
            }

            if let dest = destinationVC,
               let indexPath = tableView.indexPathForSelectedRow {
                dest.flashcard = flashcards[indexPath.row]
                dest.delegate = self
            }
        }
    }
}

// MARK: - FlashcardDelegate
extension FlashcardsTableViewController: FlashcardDelegate {
    func flashcardDidComplete(_ flashcard: Flashcard, correct: Bool) {
        var score = Persistence.shared.loadBestScore()
        if correct {
            score += 1
            Persistence.shared.saveBestScore(score)
        }

        let session = Session(
            mode: .review,
            durationMinutes: 1,
            date: Date(),
            completed: true
        )
        var sessions = Persistence.shared.loadSessions()
        sessions.append(session)
        Persistence.shared.saveSessions(sessions)
    }
}
