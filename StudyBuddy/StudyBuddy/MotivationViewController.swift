//
//  MotivationViewController.swift
//  StudyBuddy
//
//  Created by Godson JEAN on 11/14/25.
//

import UIKit

class MotivationViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Motivation"

        // Initial UI
        quoteLabel.text = ""
        authorLabel.text = ""
        activityIndicator.hidesWhenStopped = true

        // Accessibility
        quoteLabel.accessibilityIdentifier = "motivation.quoteLabel"
        authorLabel.accessibilityIdentifier = "motivation.authorLabel"
        refreshButton.accessibilityIdentifier = "motivation.refreshButton"

        fetchQuote()
    }

    // MARK: - Actions
    @IBAction func refreshTapped(_ sender: UIButton) {
        fetchQuote()
    }

    // MARK: - Networking
    private func fetchQuote() {
        // UI: show loading
        quoteLabel.text = "Loading..."
        authorLabel.text = ""
        refreshButton.isEnabled = false
        activityIndicator.startAnimating()

        APIClient.shared.fetchRandomQuote { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }

                // stop loading UI
                self.activityIndicator.stopAnimating()
                self.refreshButton.isEnabled = true

                switch result {
                case .success(let quote):
                    // Note: Quote model provided earlier exposes .text and .author
                    self.quoteLabel.text = "\"\(quote.text)\""
                    self.authorLabel.text = "- \(quote.author)"
                case .failure(let error):
                    // Friendly message + console log for devs
                    self.quoteLabel.text = "Could not load quote. Tap refresh to try again."
                    self.authorLabel.text = ""
                    print("Quote fetch failed:", error.localizedDescription)
                }
            }
        }
    }
}
