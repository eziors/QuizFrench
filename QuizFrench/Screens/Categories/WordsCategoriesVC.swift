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
        
        let wordListVC = ItemListVC(category: selectedItem.name, listType: "words")
        
        let quizVC = selectedItem.level < 2 ? QuizGuessModeVC(category: selectedItem.name, quizType: "words", currentLevel: selectedItem.level) : QuizWriteModeVC(category: selectedItem.name, quizType: "words", currentLevel: selectedItem.level)
        
        self.presentSelectionVC(title: selectedItem.name, listVC: wordListVC, quizVC: quizVC)
    }
}
