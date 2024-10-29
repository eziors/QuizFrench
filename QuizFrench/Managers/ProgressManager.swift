//
//  ProgressManager.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 18/10/24.
//

import Foundation

class ProgressManager {
    static let shared = ProgressManager()

    private init() {
        self.phrasesCategoryProgress = defaultProgress
        self.wordsCategoryProgress = defaultProgress
    }

    private let defaultProgress: [String: Int] = [
        "Numbers": 1,
        "Weekends": 3,
        "Pronouns": 3,
        "Family": 2,
        "Food": 1,
        "Clothing": 3,
        "Verbs": 0,
        "Body": 2,
    ]
    
    var phrasesCategoryProgress: [String: Int]
    var wordsCategoryProgress: [String: Int]
}

