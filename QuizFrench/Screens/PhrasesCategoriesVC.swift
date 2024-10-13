//
//  PhrasesCategoriesVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 13/10/24.
//

import UIKit

class PhrasesCategoriesVC: CategoryVC {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = categories[indexPath.item]
        
        print("Phrases Working")
    }
}
