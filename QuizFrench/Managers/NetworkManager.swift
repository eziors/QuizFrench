//
//  NetworkManager.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 03/10/24.
//

import Foundation
import Firebase

class NetworkManager {
    static let shared = NetworkManager()
    let DB_REF = Database.database().reference()
    
    private init() { }
    
    
    
    func fetchAllItems(completion: @escaping([Word]) -> Void) {
        
        var allItems = [Word]()
        
        DB_REF.child("words").observe(.childAdded) { snapshot in
            self.fetchSingleItem(id: snapshot.key) { item in
                allItems.append(item)
                completion(allItems)
            }
        }
    }
        
    func fetchSingleItem(id: String, completion: @escaping(Word) -> Void ) {
        DB_REF.child("words").child(id).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            let wordCategory = Word(keyID: id, dictionary: dictionary)
            completion(wordCategory)
        }
    }
}
