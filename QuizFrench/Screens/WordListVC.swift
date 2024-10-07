//
//  WordListVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 04/10/24.
//

import UIKit


class WordListVC: UIViewController {
    
    let tableView = UITableView()
    var category: String!
    var words: [String] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        loadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    func configureViewController() {
        view.backgroundColor    = .systemBackground
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.register(WordCell.self, forCellReuseIdentifier: WordCell.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    func loadData() {
        NetworkManager.shared.fetchAllItems { items in
            let targetCategory = self.category
            
            for item in items {
                if item.category == targetCategory {
                    for question in item.questions {
                        let word = question.correctAnswer
                        
                        if !self.words.contains(word) {
                            self.words.append(word)
                        }
                    }
                }
            }
            self.tableView.reloadData()
        }
    }
    
    
}

extension WordListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WordCell.reuseID, for: indexPath) as! WordCell
        let word = words[indexPath.row]
        
        cell.set(word: word)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
