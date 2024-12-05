//
//  ProgressManager.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 18/10/24.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

class PersistenceManager {
    
    static let shared = PersistenceManager()
    
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
    
    // ------ MARK: Saving words/phrases funcs ------
    
    func updateWith(quizType: String, favorite: Question, actionType: PersistenceActionType, completed: @escaping (QFError?) -> Void) {
        retriveFavorites(quizType: quizType) { result in
            switch result {
            case .success(var favorites):
                
                switch actionType {
                case .add:
                    guard !favorites.contains(where: { $0.translation == favorite.translation }) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    
                    favorites.append(favorite)
                    
                case .remove:
                    favorites.removeAll { $0.id == favorite.id }
                }
                
                completed(self.saveFavorites(quizType: quizType, favorites: favorites))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    func retriveFavorites(quizType: String, completed: @escaping (Result<[Question], QFError>) -> Void ) {
        guard let favoritesData = UserDefaults.standard.object(forKey: quizType) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Question].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    func saveFavorites(quizType: String, favorites: [Question]) -> QFError? {
        
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            UserDefaults.standard.set(encodedFavorites, forKey: quizType)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}

