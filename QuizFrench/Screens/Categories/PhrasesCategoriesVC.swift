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
        
        let phrasesListVC = ItemListVC()
        phrasesListVC.title = selectedItem.name
        phrasesListVC.category = selectedItem.name
        phrasesListVC.listType = "phrases"
        
        let quizVC = QuizWriteModeVC()
        quizVC.title = selectedItem.name
        quizVC.category = selectedItem.name
        quizVC.quizType = "phrases"
        
        self.presentSelectionVC(title: selectedItem.name, listVC: phrasesListVC, quizVC: quizVC)
    }
}
