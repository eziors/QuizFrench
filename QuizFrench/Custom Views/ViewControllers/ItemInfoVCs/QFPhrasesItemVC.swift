//
//  QFPhrasesItemVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 13/09/24.
//

import UIKit

class QFPhrasesItemVC: QFItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureItems()
    }
    

    func configureItems() {
        itemInfoView.set(type: .phrases)
        self.set(backgroundColor: UIColor(red: 0.71, green: 0.28, blue: 0.75, alpha: 1.00))
    }

}
