//
//  QFWordsCategoryVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 28/09/24.
//

import UIKit

class WordsCategoriesVC: ItemCategoryVC {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = categories[indexPath.item]
        
        let wordListVC = ItemListVC()
        wordListVC.title = selectedItem.name
        wordListVC.category = selectedItem.name
        wordListVC.listType = "words"
        
        let quizVC = QuizWriteModeVC()
        quizVC.title = selectedItem.name
        quizVC.category = selectedItem.name
        quizVC.quizType = "words"
        quizVC.currentLevel = selectedItem.level
        
        self.presentSelectionVC(title: selectedItem.name, listVC: wordListVC, quizVC: quizVC)
        
        
    }
}
