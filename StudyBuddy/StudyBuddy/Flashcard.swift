//
//  Flashcard.swift
//  StudyBuddy
//
//  Created by Godson JEAN on 11/07/25.
//

import Foundation

struct Flashcard: Codable {
    let id: Int
    let question: String
    let answer: String
    let tags: [String]?
}
