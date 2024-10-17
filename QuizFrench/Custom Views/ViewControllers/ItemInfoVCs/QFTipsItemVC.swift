//
//  QFTipsItemVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 13/09/24.
//

import UIKit

class QFTipsItemVC: QFItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
    }
    
    func configureItems() {
        itemInfoView.set(type: .tips)
        self.set(backgroundColor: UIColor(red: 0.84, green: 0.69, blue: 0.10, alpha: 1.00))
    }
    
    override func actionButtonTapped() {
        print("Tips is working !")
    }
}
