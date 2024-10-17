//
//  WordsListVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 14/10/24.
//

import UIKit

class WordsListVC: ItemListVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        listType = "words"
    }
}
