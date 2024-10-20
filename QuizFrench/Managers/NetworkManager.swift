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
