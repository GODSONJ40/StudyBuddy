//
//  DashboardViewController.swift
//  StudyBuddy
//
//  Created by Godson JEAN on 11/07/25.
//

import UIKit

class DashboardViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var bestScoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startPauseButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!

    // MARK: - Timer Properties
    private var statsContainerVC: StatsContainerViewController?

    private var timer: Timer?
    private var remainingSeconds = 25 * 60   // Default: 25 minutes
    private var isRunning = false
    private var currentMode: StudyMode = .focus

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Dashboard"

        updateUserInfo()
        updateTimerLabel()

        // Detect child StatsContainerViewController
        for child in children {
            if let sc = child as? StatsContainerViewController {
                statsContainerVC = sc
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUserInfo()
        statsContainerVC?.updateStats()
    }

    // MARK: - UI Updates
    private func updateUserInfo() {
//        greetingLabel.text = "Welcome, \n\(Persistence.shared.loadUsername() ?? "Student")"
        
        let username = Persistence.shared.loadUsername() ?? "Student"

        let fullText = "Welcome,\n\(username)"
        let attributed = NSMutableAttributedString(string: fullText)

        // Make the word "Welcome" bigger
        attributed.addAttribute(.font,
                                value: UIFont.systemFont(ofSize: 30, weight: .bold),
                                range: (fullText as NSString).range(of: "Welcome"))

        // Apply the rest of the text as normal size
        attributed.addAttribute(.font,
                                value: UIFont.systemFont(ofSize: 18),
                                range: (fullText as NSString).range(of: username))

        greetingLabel.attributedText = attributed

        bestScoreLabel.text = "Best Score: \(Persistence.shared.loadBestScore())"
    }

    private func updateTimerLabel() {
        let minutes = remainingSeconds / 60
        let seconds = remainingSeconds % 60
        timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }

    // MARK: - Button Actions
    @IBAction func startPauseTapped(_ sender: UIButton) {
        isRunning ? pauseTimer() : startTimer()
    }

    @IBAction func resetTapped(_ sender: UIButton) {
        resetTimer()
    }

    // MARK: - Timer Logic
    private func startTimer() {
        guard timer == nil else { return }  // Prevent multiple timers

        isRunning = true
        startPauseButton.setTitle("Pause", for: .normal)
        startPauseButton.setTitleColor(.red, for: .normal)

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.tick()
        }
    }

    private func pauseTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil

        startPauseButton.setTitle("Start", for: .normal)
        startPauseButton.setTitleColor(.systemBlue, for: .normal)
    }

    private func resetTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil

        remainingSeconds = 25 * 60
        updateTimerLabel()

        startPauseButton.setTitle("Start", for: .normal)
        startPauseButton.setTitleColor(.systemBlue, for: .normal)
    }

    private func tick() {
        guard remainingSeconds > 0 else {
            completeSession()
            return
        }

        remainingSeconds -= 1
        updateTimerLabel()
    }

    private func completeSession() {
        timer?.invalidate()
        timer = nil
        isRunning = false

        startPauseButton.setTitle("Start", for: .normal)
        startPauseButton.setTitleColor(.systemBlue, for: .normal)

        let totalSeconds = (25 * 60) - remainingSeconds
        let minutesCompleted = max(totalSeconds / 60, 1)

        let session = Session(
            mode: currentMode,
            durationMinutes: minutesCompleted,
            date: Date(),
            completed: true
        )

        var sessions = Persistence.shared.loadSessions()
        sessions.append(session)
        Persistence.shared.saveSessions(sessions)

        statsContainerVC?.updateStats()

        let alert = UIAlertController(
            title: "Session Complete",
            message: "Great job! Keep going!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)

        resetTimer()
    }
}
