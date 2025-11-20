//
//  Session.swift
//  StudyBuddy
//
//  Created by Godson JEAN on 11/16/25.
//

import Foundation

enum StudyMode: String, Codable {
    case focus, breakTime = "break", review
}

struct Session: Codable {
    var id: UUID = UUID()
    var mode: StudyMode
    var durationMinutes: Int
    var date: Date
    var completed: Bool
}
