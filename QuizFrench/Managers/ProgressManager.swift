//
//  ProgressManager.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 18/10/24.
//

import Foundation

class ProgressManager {
    
    static let shared = ProgressManager()
    
    enum Keys {
        static let wordsQuiz = "wordsQuiz"
        static let phrasesQuiz = "phrasesQuiz"
    }
    
    var wordsQuizDictionary: [String: Int] = [
        "Numbers": 0, // Starting with default values 
        "Weekends": 0,
        "Pronouns": 0,
        "Family": 0,
        "Food": 0,
        "Clothing": 0,
        "Verbs": 0,
        "Body": 0,
    ]

    private init() { }

    
    func retrieveQuizProgress(quizType: String, category: String) -> Int {
        let key = "\(quizType)_\(category)"
        
       
        let quizProgress = UserDefaults.standard.integer(forKey: key)
        print("Loaded successfully !")
        return quizProgress
    }

    
    func save(quizType: String, category: String, currentLevel: Int)  {
        let key = "\(quizType)_\(category)"
        let newLevel = currentLevel + 1
        
        UserDefaults.standard.set(newLevel, forKey: key)
    }
}

