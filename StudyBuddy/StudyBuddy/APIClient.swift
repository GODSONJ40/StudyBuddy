//
//  APIClient.swift
//  StudyBuddy
//
//  Created by Godson JEAN on 11/07/25.
//

import Foundation

// MARK: - Motivation Quote Model (ZenQuotes API)
struct MotivationQuote: Decodable {
    let quote: String
    let author: String

    // ZenQuotes JSON uses keys "q" and "a"
    enum CodingKeys: String, CodingKey {
        case quote = "q"
        case author = "a"
    }

    // For MotivationViewController compatibility
    var text: String { quote }
}

final class APIClient {

    // MARK: - Singleton
    static let shared = APIClient()
    private init() {}

    // ZenQuotes endpoint (NO key required)
    private let quoteURL = URL(string: "https://zenquotes.io/api/random")!

    // MARK: - Fetch Random Quote
    func fetchRandomQuote(completion: @escaping (Result<MotivationQuote, Error>) -> Void) {

        print("🌐 Fetching from:", quoteURL.absoluteString)

        URLSession.shared.dataTask(with: quoteURL) { data, response, error in

            // Network error
            if let error = error {
                print("❌ NETWORK ERROR:", error.localizedDescription)
                completion(.failure(error))
                return
            }

            // No data
            guard let data = data else {
                print("❌ No Data Returned")
                completion(.failure(NSError(domain: "NoData", code: -2)))
                return
            }

            // Print raw JSON (for debugging)
            if let raw = String(data: data, encoding: .utf8) {
                print("📦 RAW JSON:", raw)
            }

            do {
                // ZenQuotes returns an ARRAY of quotes → decode to array
                let decodedArray = try JSONDecoder().decode([MotivationQuote].self, from: data)

                if let firstQuote = decodedArray.first {
                    print("✅ Decoded Quote:", firstQuote)
                    completion(.success(firstQuote))
                } else {
                    print("❌ JSON Array Empty")
                    completion(.failure(NSError(domain: "EmptyArray", code: -3)))
                }

            } catch {
                print("❌ DECODING ERROR:", error)
                completion(.failure(error))
            }

        }.resume()
    }

    // MARK: - Fetch Flashcards (Optional for future cloud API)
    func fetchFlashcards(from url: URL, completion: @escaping (Result<[Flashcard], Error>) -> Void) {

        URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: -1)))
                return
            }

            do {
                let flashcards = try JSONDecoder().decode([Flashcard].self, from: data)
                completion(.success(flashcards))
            } catch {
                completion(.failure(error))
            }

        }.resume()
    }
}

