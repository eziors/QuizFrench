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
    
    static let wordExamples = [
        Word(category: "Numbers", questions: Question.questionsExamples)
    ]
    
    // --- Question Struct ---
    struct Question {
        var questionText: String
        var options: Option
        var correctAnswer: String
        
        static let questionExample = Question(questionText: "How old are you ?", options: Option.optionExample, correctAnswer: "D")
        
        static let questionsExamples = [
            Question(questionText: "How old are you ?", options: Option.optionExample, correctAnswer: "Salut"),
            Question(questionText: "I'm here just working for free", options: Option.optionExample, correctAnswer: "Deux"),
            Question(questionText: "Help me !!", options: Option.optionExample, correctAnswer: "Ensemble"),
            Question(questionText: "Can i help you with something ?", options: Option.optionExample, correctAnswer: "Voiture"),
            Question(questionText: "Bla bla bla bla !", options: Option.optionExample, correctAnswer: "Eux"),
        ]
        
        // --- Option Struct ---
        struct Option {
            var a: String
            var b: String
            var c: String
            var d: String
            
            static let optionExample = Option(a: "A", b: "B", c: "C", d: "D")
        }
    }
   
}

extension Word {
    // Inicializador para converter o dicionário para o struct WordCategory
    init(keyID: String, dictionary: [String: Any]) {
        self.category = dictionary["category"] as? String ?? ""
        
        // Converter array de dicionários de perguntas para array de structs Question
        if let questionsArray = dictionary["questions"] as? [[String: Any]] {
            self.questions = questionsArray.map { Question(dictionary: $0) }
        } else {
            self.questions = [Question.questionExample]
        }
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


extension Word.Question {
    init(dictionary: [String: Any]) {
            self.questionText = dictionary["question"] as? String ?? ""
            self.options = Option(dictionary: dictionary)
            self.correctAnswer = dictionary["correct"] as? String ?? ""
        }
}







