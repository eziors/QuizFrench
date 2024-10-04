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
    
    
    
        func fetchAllItems() {
            DB_REF.child("words").observe(.childAdded) { snapshot in
                self.fetchSingleItem(id: snapshot.key)
                
            }
        }
        
        func fetchSingleItem(id: String) {
            DB_REF.child("words").child(id).observeSingleEvent(of: .value) { snapshot in
                guard let dictionary = snapshot.value as? [String: Any] else { return }
                
                let wordCategory = WordCategory(keyID: id, dictionary: dictionary)
                
                print(wordCategory)
            }
        }
    
}
