//
//  WordListVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 04/10/24.
//

import UIKit

import UIKit

class FavoritesListVC: UIViewController {
    
    let tableView = UITableView()
    var favorites: [Word]   = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    func configureViewController() {
        view.backgroundColor    = .systemBackground
        title                   = "Words"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame         = view.bounds
        tableView.rowHeight     = 80
        tableView.register(WordCell.self, forCellReuseIdentifier: WordCell.reuseID)
    }
    
    
}

