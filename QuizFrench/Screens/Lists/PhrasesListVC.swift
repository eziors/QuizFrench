//
//  PhrasesListVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 14/10/24.
//

import UIKit

class PhrasesListVC: ItemListVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        listType = "phrases"
    }
}
