//
//  Persistence.swift
//  StudyBuddy
//
//  Created by Godson JEAN on 11/07/25.
//

import Foundation

final class Persistence {
    private init() {}

    static let shared = Persistence()
    private let sessionsKey = "study_sessions"
    private let usernameKey = "username"
    private let bestScoreKey = "bestScore"

    private var defaults: UserDefaults { .standard }

    // Sessions (serialize as JSON)
    func saveSessions(_ sessions: [Session]) {
        do {
            let data = try JSONEncoder().encode(sessions)
            defaults.set(data, forKey: sessionsKey)
        } catch {
            print("Failed to encode sessions: \(error)")
        }
    }

    func loadSessions() -> [Session] {
        guard let data = defaults.data(forKey: sessionsKey) else { return [] }
        do {
            return try JSONDecoder().decode([Session].self, from: data)
        } catch {
            print("Failed to decode sessions: \(error)")
            return []
        }
    }

    // Username
    func saveUsername(_ username: String) {
        defaults.set(username, forKey: usernameKey)
    }
    func loadUsername() -> String? {
        defaults.string(forKey: usernameKey)
    }

    // BestScore (example: total correct marks or minutes)
    func saveBestScore(_ value: Int) {
        defaults.set(value, forKey: bestScoreKey)
    }
    func loadBestScore() -> Int {
        defaults.integer(forKey: bestScoreKey)
    }
}
