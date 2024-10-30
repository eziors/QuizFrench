//
//  UIViewController+Ext.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 15/10/24.
//

import UIKit

extension UIViewController {
    
    func presentSelectionVC(title: String, listVC: UIViewController, quizVC: UIViewController) {
        DispatchQueue.main.async {
            let selectionVC = QFSelectionVC(title: title, listVC: listVC, quizVC: quizVC)
            let navController = UINavigationController(rootViewController: selectionVC)
            navController.modalTransitionStyle = .crossDissolve
            navController.modalPresentationStyle = .overFullScreen
            self.present(navController, animated: true)
        }
    }
    
    func presentAlertContainer(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = QFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalTransitionStyle = .crossDissolve
            alertVC.modalPresentationStyle = .overFullScreen
            self.present(alertVC, animated: true)
        }
    }
    
    func presentCompletedQuizContainer(title: String, message: String, buttonTitle: String, navController: UINavigationController) {
        DispatchQueue.main.async {
            let alertVC = QFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.alertType = .quizContainer
            alertVC.navController = navController
            alertVC.modalTransitionStyle = .crossDissolve
            alertVC.modalPresentationStyle = .overFullScreen
            self.present(alertVC, animated: true)
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


 

 
