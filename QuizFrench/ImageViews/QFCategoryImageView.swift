//
//  QFCategoryImageView.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 28/09/24.
//

import UIKit

class QFCategoryImageView: UIImageView {

    let placeholderImage = UIImage(systemName: "photo.fill")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 12
        
        contentMode = .scaleToFill
        image = placeholderImage
    }
    
    func setImage(imageURL: String) {
        image = UIImage(named: imageURL)
    }
}
