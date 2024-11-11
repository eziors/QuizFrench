//
//  WordListVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 04/10/24.
//

import UIKit


class ItemListVC: UIViewController {
    
    let tableView = UITableView()
    var category: String!
    var listType: String!
    var questions: [Question] = []
    
    init(category: String, listType: String) {
        super.init(nibName: nil, bundle: nil)
        self.category = category
        self.listType = listType
        title = category
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        loadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = UIColor.systemBlue
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

    
    func loadData() {
        DataManager.shared.getListQuestions(for: listType, category: category) { result in
            switch result {
            case .success(let questions):
                self.questions = questions
            case .failure(let failure):
                print(failure.rawValue)
            }
        }
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

extension ItemListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.reuseID, for: indexPath) as! ItemCell
        let word = questions[indexPath.row]
        
        cell.set(wordString: word, for: "word")
        
        return cell
    }
}

