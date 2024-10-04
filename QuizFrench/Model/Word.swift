//
//  WordItem.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 03/10/24.
//

import Foundation
import Firebase


// --- Word Struct ---
struct Word {
    var category: String
    var questions: [Question]
    
    // --- Question Struct ---
    struct Question {
        var questionText: String
        var options: Option
        var correctAnswer: String
        
        // --- Option Struct ---
        struct Option {
            var a: String
            var b: String
            var c: String
            var d: String
            
            
            static let optionExample = Option(a: "A", b: "B", c: "C", d: "D")
        }
        
        
        static let questionExample = Question(questionText: "How old are you?", options: Option.optionExample, correctAnswer: "D")
    }
}



extension Word {
    init(keyID: String, dictionary: [String: Any]) {
        self.category = dictionary["category"] as? String ?? ""
        self.questions = (dictionary["questions"] as? [[String: Any]] ?? []).map { Question(dictionary: $0) }
    }
}

extension Word.Question {
    init(dictionary: [String: Any]) {
        self.questionText = dictionary["question"] as? String ?? ""
        self.options = Option(dictionary: dictionary["options"] as? [String: Any] ?? [:])
        self.correctAnswer = dictionary["correct"] as? String ?? ""
    }
}

extension Word.Question.Option {
    init(dictionary: [String: Any]) {
        self.a = dictionary["a"] as? String ?? ""
        self.b = dictionary["b"] as? String ?? ""
        self.c = dictionary["c"] as? String ?? ""
        self.d = dictionary["d"] as? String ?? ""
    }
}







