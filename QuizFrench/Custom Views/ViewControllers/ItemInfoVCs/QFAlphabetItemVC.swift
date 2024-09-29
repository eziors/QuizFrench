//
//  QFAlphabetItemVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 13/09/24.
//

import UIKit

class QFAlphabetItemVC: QFItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
    }
    
    func configureItems() {
        itemInfoView.set(type: .alphabets)
        self.set(backgroundColor: UIColor(red: 0.27, green: 0.75, blue: 0.43, alpha: 1.00))
    }
    
    override func actionButtonTapped() {
        delegate.didTapAlphabet()
    }
}
