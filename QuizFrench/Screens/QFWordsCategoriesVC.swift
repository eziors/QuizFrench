//
//  QFWordsCategoryVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 28/09/24.
//

import UIKit

class QFWordsCategoriesVC: UIViewController {
    
    enum Section { case main }
    
    let categoriesNames = ["Numbers", "Weekends", "Pronouns", "Family", "Food", "Clothing", "Verbs", "Body Parts"]
    var categories = [Category]()

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Category>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAlphabet()
        configureCollectionView()
        configureDataSource()
        updateData()
        print(categories)
        
        
    }
    
    private func configureAlphabet() {
        for name in categoriesNames {
            let category = Category(name: name, image: "\(name) Testing") // alphabet_Aa.mp3, alphabet_Bb.mp3
            categories.append(category)
        }
    }

    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createTwoColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(WordCategoryCell.self, forCellWithReuseIdentifier: WordCategoryCell.reuseID)
    }
    
    func createTwoColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let itemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (itemSpacing * 2)
        let itemWidth = availableWidth / 2
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 20)
        
        return flowLayout
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
