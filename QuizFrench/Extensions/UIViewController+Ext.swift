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

    
}


 

 
