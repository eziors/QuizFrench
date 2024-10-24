//
//  CategoryVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 13/10/24.
//

import UIKit

class ItemCategoryVC: UIViewController {
    
    enum Section { case main }
    
    let categoriesNames = ["Numbers", "Weekends", "Pronouns", "Family", "Food", "Clothing", "Verbs", "Body"]
    var categories = [Category]()
    var categoryType: CategoryType!

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Category>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCategories()
        configureCollectionView()
        configureDataSource()
        
        updateData()
    }
    
    private func configureCategories() {
        for name in categoriesNames {
            let category = Category(name: name, image: "category_\(name.lowercased())", completedLevels: getCategoryLevel(for: categoryType, category: name)) // testing
            categories.append(category)
        }
    }
    
    func getCategoryLevel(for categoryType: CategoryType, category: String) -> Int {
        switch categoryType {
        case .words:
            return ProgressManager.shared.wordsCategoryProgress[category] ?? 0
        case .phrases:
            return ProgressManager.shared.phrasesCategoryProgress[category] ?? 0
        }
    }

    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createTwoColumnFlowLayout(in: view, for: .category))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseID)
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, category in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseID, for: indexPath) as! CategoryCell
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

extension ItemCategoryVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { }
}

