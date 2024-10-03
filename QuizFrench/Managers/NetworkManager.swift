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
    
    func getData() {
        DB_REF.child("words").observe(.childAdded) { data in
            print(data)
        }
    }
}
