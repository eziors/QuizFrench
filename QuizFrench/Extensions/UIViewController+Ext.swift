//
//  UIViewController+Ext.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 15/10/24.
//

import UIKit

extension UIViewController {
    func presentSelectionVC() {
        DispatchQueue.main.async {
            let selectionVC = QFSelectionVC()
            selectionVC.modalTransitionStyle = .crossDissolve
            selectionVC.modalPresentationStyle = .overFullScreen
            self.present(selectionVC, animated: true)
        }
    }
}
