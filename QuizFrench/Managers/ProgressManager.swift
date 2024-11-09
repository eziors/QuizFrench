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

