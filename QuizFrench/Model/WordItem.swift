//
//  WordItem.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 03/10/24.
//

import Foundation

struct Option {
    let english: String
    let portuguese: String
    
    static let optionExample = Option(english: "English", portuguese: "Portuguese")
}


struct Question {
    let question: String
    let options: [String: Option]
    let correct: String
    
    static let example = Question(question: "Testing", options: ["Test": Option.optionExample], correct: "c")
    
    
}


struct WordItem {
    let categoryName: String
    let questions: [Question]
    
    init(keyID: String, dictionary: [String: Any]) {
        self.categoryName = dictionary["categoryName"] as? String ?? ""
        
        // Verificando se a chave "questions" é um array de dicionários
        if let questionDicts = dictionary["questions"] as? [[String: Any]] {
            // Convertendo os dicionários em instâncias de Question
            self.questions = questionDicts.compactMap { dict in
                if let questionText = dict["question"] as? String,
                   let optionsDict = dict["options"] as? [String: [String: String]], // Modifique conforme a estrutura dos dados
                   let correct = dict["correct"] as? String {
                    
                    let options = optionsDict.reduce(into: [String: Option]()) { result, pair in
                        if let english = pair.value["english"],
                           let portuguese = pair.value["portuguese"] {
                            result[pair.key] = Option(english: english, portuguese: portuguese)
                        }
                    }
                    
                    return Question(question: questionText, options: options, correct: correct)
                }
                return nil
            }
        } else {
            // Caso não haja perguntas no dicionário, usa o valor padrão
            self.questions = [Question.example]
        }
    }
}


