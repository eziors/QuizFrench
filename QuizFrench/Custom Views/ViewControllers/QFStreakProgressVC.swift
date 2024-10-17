//
//  QFStreakProgressVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 11/09/24.
//

import UIKit

class QFStreakProgressVC: QFProgressVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        self.progressViewOne.set(progressType: .streak, progressCount: 20)
        self.progressViewTwo.set(progressType: .trophy, progressCount: 3)
    }
}
