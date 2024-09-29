//
//  QFCategoryImageView.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 28/09/24.
//

import UIKit

class QFCategoryImageView: UIImageView {

    let placeholderImage = UIImage(systemName: "photo")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
        image = placeholderImage
        
        print("Image is working ! ")
    }
    
    func setImage(imageURL: String) {
        image = UIImage(named: imageURL)
    }
}
