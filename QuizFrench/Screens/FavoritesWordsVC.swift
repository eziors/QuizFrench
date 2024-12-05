//
//  FavoritesWordsVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 11/11/24.
//

import UIKit

class FavoritesWordVC: UIViewController {
    
    let tableView = UITableView()
    var favorites: [Question] = []
    
    var quizType: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        getFavorites()
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ItemCell.self, forCellReuseIdentifier: ItemCell.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }

    
    func getFavorites() {
        PersistenceManager.shared.retriveFavorites(quizType: quizType) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                self.updateUI(with: favorites)
                print(favorites)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.presentAlertContainer(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
            }
        }
    }
    
    func updateUI(with favorites: [Question]) {
        if favorites.isEmpty {
            //self.showEmptyStateView(with: "No Favorites? \nAdd one on the following screen.", in: self.view)
            print("Empty list !")
        } else {
            DispatchQueue.main.async {
                self.favorites = favorites
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)
            }
        }
    }
}


extension FavoritesWordVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.reuseID, for: indexPath) as! ItemCell
        let question = favorites[indexPath.row]
        cell.set(question: question, favorites: favorites, for: quizType, viewController: self)
        return cell
    }
}


/*
 func loadData() {
     DataManager.shared.fetchAllItems(itemType: listType) { items in
         let selectedCategory = self.category
                 
         for item in items {
             if item.category == selectedCategory {
                 for question in item.questions {
                     
                     if !self.words.contains(where: { $0.correctAnswer == question.correctAnswer }) {
                         self.words.append(question)
                     }
                 }
             }
         }
         
         for word in self.words {
             print(word.correctAnswer)
         }
         DispatchQueue.main.async {
             self.tableView.reloadData()
         }
     }
 }
 */
