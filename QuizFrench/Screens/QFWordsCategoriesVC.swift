//
//  QFWordsCategoryVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 28/09/24.
//

import UIKit

class QFWordsCategoriesVC: UIViewController {
    
    enum Section { case main }
    
    let categoriesNames = ["Numbers", "Weekends", "Pronouns", "Family", "Food", "Clothing", "Verbs", "Body"]
    var categories = [Category]()

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Category>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAlphabet()
        configureCollectionView()
        configureDataSource()
        updateData()
    }
    
    private func configureAlphabet() {
        for name in categoriesNames {
            let category = Category(name: name, image: "category_\(name.lowercased())") // testing
            categories.append(category)
        }
    }

    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createTwoColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(WordCategoryCell.self, forCellWithReuseIdentifier: WordCategoryCell.reuseID)
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, category in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WordCategoryCell.reuseID, for: indexPath) as! WordCategoryCell
            cell.set(category: category)
            
            return cell
        })
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Category>()
        snapshot.appendSections([.main])
        snapshot.appendItems(categories)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
}
