//
//  Quote.swift
//  StudyBuddy
//
//  Created by Godson JEAN on 11/16/25.
//

import Foundation

struct Quote: Codable {
    // ZenQuotes returns array of objects
    let q: String
    let a: String

    var text: String { q }
    var author: String { a }
}
