//
//  QFWordsItemVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 13/09/24.
//

import UIKit

class QFWordsItemVC: QFItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureItems()
    }
    

    func configureItems() {
        itemInfoView.set(type: .words)
        self.set(backgroundColor: UIColor(red: 0.08, green: 0.42, blue: 0.78, alpha: 1.00))
    }

    override func actionButtonTapped() {
        delegate.didTapWords()
    }
}
