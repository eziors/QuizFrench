//
//  QFWordsCategoryVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 28/09/24.
//

import UIKit

class WordsCategoriesVC: CategoryVC {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = categories[indexPath.item]
        
        let wordListVC = WordListVC()
        wordListVC.title = selectedItem.name
        wordListVC.category = selectedItem.name
        
        navigationController?.pushViewController(wordListVC, animated: true)
        
        print(selectedItem)
    }
}
