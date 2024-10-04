//
//  WordItem.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 03/10/24.
//

import Foundation
import Firebase

struct Option {
    var a: String
    var b: String
    var c: String
    var d: String
    
    static let optionExample = Option(a: "A", b: "B", c: "C", d: "D")
    
}

extension Option {
    init(dictionary: [String: Any]) {
            self.a = dictionary["a"] as? String ?? ""
            self.b = dictionary["b"] as? String ?? ""
            self.c = dictionary["c"] as? String ?? ""
            self.d = dictionary["d"] as? String ?? ""
        }
}


struct Question {
    var questionText: String
    var options: Option
    var correctAnswer: String
    
    static let questionExample = Question(questionText: "How old are you ?", options: Option.optionExample, correctAnswer: "D")
    
}

extension Question {
    init(dictionary: [String: Any]) {
            self.questionText = dictionary["question"] as? String ?? ""
            let optionsDict = dictionary["options"] as? [String: Any] ?? [:]
            self.options = Option(dictionary: dictionary)
            self.correctAnswer = dictionary["correct"] as? String ?? ""
        }
}


struct Word {
    var category: String
    var questions: [Question]
    
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




