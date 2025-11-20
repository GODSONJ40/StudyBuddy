//
//  StatsContainerViewController.swift
//  StudyBuddy
//
//  Created by Godson JEAN on 11/17/25.
//

import UIKit

class StatsContainerViewController: UIViewController {

    @IBOutlet weak var totalSessionsLabel: UILabel!
    @IBOutlet weak var totalMinutesLabel: UILabel!

    // Optional: card views if you connected them for styling
    @IBOutlet weak var cardAView: UIView?
    @IBOutlet weak var cardBView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        styleCards()
        updateStats()
    }

    private func styleCards() {
        // Rounded corners & subtle shadow (optional)
        [cardAView, cardBView].forEach { view in
            guard let v = view else { return }
            v.layer.cornerRadius = 10
            v.clipsToBounds = true
            // subtle shadow on parent (if not clipped)
            // v.layer.shadowColor = UIColor.black.cgColor
            // v.layer.shadowOpacity = 0.05
            // v.layer.shadowOffset = CGSize(width: 0, height: 2)
            // v.layer.shadowRadius = 4
        }
    }

    func updateStats() {
        let sessions = Persistence.shared.loadSessions()
        let totalSessions = sessions.count
        let totalMinutes = sessions.reduce(0) { $0 + $1.durationMinutes }

        totalSessionsLabel.text = "\(totalSessions)"
        totalMinutesLabel.text = "\(totalMinutes) min"
    }
}
