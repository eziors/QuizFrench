//
//  Collection+Ext.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 07/10/24.
//

import Foundation

extension Collection where Element == String {
    func sortedPronouns() -> [String] {
        var sortedPronouns: [String] = []
        
        
        let order = ["Je","Tu","Il","Elle","On","Nous","Vous","Ils","Elles"]
        
        for i in order {
            for j in self {
                if j == i {
                    sortedPronouns.append(j)
                }
            }
        }
        return sortedPronouns
    }
}

