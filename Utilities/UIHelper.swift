//
//  UIHelper.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 29/10/24.
//

import UIKit

enum CollectionType {
    case alphabet, category
}

enum CategoryType {
    case phrases, words
}

enum ContentType {
    case quiz, list
}

struct UIHelper {
    static func createTwoColumnFlowLayout(in view: UIView, for collectionType: CollectionType) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let itemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (itemSpacing * 2)
        let itemWidth = availableWidth / 2
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        switch collectionType {
        case .alphabet:
            flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 20)

        case .category:
            flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 60)

        }
        return flowLayout
    }
    
    static func createFiveColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 10
        let itemSpacing: CGFloat = 20
        let availableWidth = width - (padding * 4) - (itemSpacing * 4)
        let itemWidth = availableWidth / 5
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth , height: itemWidth )
        return flowLayout
    }

}

