//
//  PhrasesCategoriesVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 13/10/24.
//

import UIKit

class PhrasesCategoriesVC: ItemCategoryVC {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = categories[indexPath.item]
        
        let phrasesListVC = ItemListVC(category: selectedItem.name, listType: "phrases")
        
        
        let quizVC = selectedItem.level < 2 ? QuizGuessModeVC(category: selectedItem.name, quizType: "phrases", currentLevel: selectedItem.level) : QuizWriteModeVC(category: selectedItem.name, quizType: "phrases", currentLevel: selectedItem.level)
        
        
        self.presentSelectionVC(
            description: selectedItem.name,
            firstVC: phrasesListVC,
            firstVCTitle: "Practice",
            secondVC: quizVC,
            secondVCTitle: "Quiz"
        )
    }
}
