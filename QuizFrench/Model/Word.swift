//
//  Word.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 03/10/24.
//

import Foundation

struct Option {
    let english: String
    let portuguese: String
}

// Representa uma questão com uma pergunta e opções de resposta
struct Question {
    let question: String
    let options: [String: Option] // As opções serão armazenadas com chaves "a", "b", "c", "d"
    let correct: String           // Indica a chave correta ("a", "b", "c" ou "d")
}
