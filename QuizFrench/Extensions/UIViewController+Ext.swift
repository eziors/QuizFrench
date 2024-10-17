//
//  UIViewController+Ext.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 15/10/24.
//

import UIKit

extension UIViewController {
    
    func presentSelectionVC(title: String, for viewController: UIViewController) {
        DispatchQueue.main.async {
            let selectionVC = QFSelectionVC(title: title, for: viewController)
            let navController = UINavigationController(rootViewController: selectionVC)
            navController.modalTransitionStyle = .crossDissolve
            navController.modalPresentationStyle = .overFullScreen
            self.present(navController, animated: true)
        }
    }
    
    func loadQuote() -> String {
        
        guard let startWordsURL = Bundle.main.url(forResource: "quotes", withExtension: "txt") else {
            return "Nothing found yet"
        }
        
        do {
            let startWords = try String(contentsOf: startWordsURL)
            let allWords = startWords.components(separatedBy: "\n")
            
            return allWords.randomElement()!
        } catch {
            
            return "N/A"
        }
    }
}


 

 
