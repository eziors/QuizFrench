//
//  NetworkManager.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 03/10/24.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    private init() { }
    
    func getQuestions(for selectedFile: String, category: String, contentType: ContentType, completed: @escaping (Result<[Question], QFError>) -> Void) {
        var questionsArray: [Question] = []
        
        guard let url = Bundle.main.url(forResource: selectedFile, withExtension: "json") else {
            completed(.failure(.urlError))
            return
        }
        
        guard let data = try? Data(contentsOf: url) else {
            completed(.failure(.dataError))
            return
        }
        
        let decoder = JSONDecoder()
        
        do {
            let decodedItems = try decoder.decode(Item.self, from: data)
            
            for item in decodedItems.items {
                if item.category == category {
                    
                    switch contentType {
                    case .quiz:
                        questionsArray = item.questions
                        completed(.success(questionsArray))
                    case .list:
                        for question in item.questions {
                            if !questionsArray.contains(where: { $0.correct == question.correct }) {
                                questionsArray.append(question)
                            }
                        }
                        completed(.success(questionsArray))
                    }
                }
            }
            
        } catch {
            print("Error in do catch block \(error)")
            completed(.failure(.dataError))
        }
    }

}


/* --------- Deprecated ---------
 
 class NetworkManager {
     static let shared = NetworkManager()
     let DB_REF = Database.database().reference()
     
     private init() { }
     
     
     
     func fetchAllItems(itemType: String, completion: @escaping([Item]) -> Void) {
         
         var allItems = [Item]()
         
         DB_REF.child(itemType).observe(.childAdded) { snapshot in
             self.fetchSingleItem(for: itemType, id: snapshot.key) { item in
                 allItems.append(item)
                 completion(allItems)
             }
         }
     }
         
     func fetchSingleItem(for itemType: String, id: String, completion: @escaping(Item) -> Void ) {
         DB_REF.child(itemType).child(id).observeSingleEvent(of: .value) { snapshot in
             guard let dictionary = snapshot.value as? [String: Any] else { return }
             let wordCategory = Item(keyID: id, dictionary: dictionary)
             completion(wordCategory)
         }
     }
 }


*/
