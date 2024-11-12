//
//  FavoritesWordsVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 11/11/24.
//

import UIKit

class FavoritesWordsVC: UIViewController {
    
    let tableView = UITableView()
    var favorites = [Question]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
