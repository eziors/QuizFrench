//
//  WordItem.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 03/10/24.
//

import Foundation
import Firebase

struct Option {
    var optionA: String
    var optionB: String
    var optionC: String
    var optionD: String
    
    static let optionExample = Option(optionA: "A", optionB: "B", optionC: "C", optionD: "D")
    
}

extension Option {
    init(dictionary: [String: Any]) {
            self.optionA = dictionary["a"] as? String ?? ""
            self.optionB = dictionary["b"] as? String ?? ""
            self.optionC = dictionary["c"] as? String ?? ""
            self.optionD = dictionary["d"] as? String ?? ""
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
            self.options = Option(dictionary: optionsDict)
            self.correctAnswer = dictionary["correct"] as? String ?? ""
        }
}


struct WordCategory {
    var name: String
    var questions: [Question]
    
    // Inicializador para converter o dicionário para o struct WordCategory
    init(keyID: String, dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        
        // Converter array de dicionários de perguntas para array de structs Question
        if let questionsArray = dictionary["questions"] as? [[String: Any]] {
            self.questions = questionsArray.map { Question(dictionary: $0) }
        } else {
            self.questions = [Question.questionExample]
        }
    }
}




