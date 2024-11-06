//
//  QuizCell.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 01/11/24.
//

import UIKit

class QuizCell: UICollectionViewCell {
    
    static let reuseID = "QuizCell"
    let character = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(for letter: Letter) {
        character.text = letter.letter
    }
    
    private func configure() {
        addSubview(character)
        character.translatesAutoresizingMaskIntoConstraints = false 
        character.textColor = .label
        character.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        character.backgroundColor = UIColor.systemGray6
        character.layer.cornerRadius = 5
        character.layer.borderWidth = 2
        character.clipsToBounds = true
        character.layer.borderColor = UIColor.systemGray3.cgColor
        character.textAlignment = .center
        
        
        
        
        NSLayoutConstraint.activate([
            character.topAnchor.constraint(equalTo: topAnchor),
            character.leadingAnchor.constraint(equalTo: leadingAnchor),
            character.trailingAnchor.constraint(equalTo: trailingAnchor),
            character.widthAnchor.constraint(equalToConstant: 40),
            character.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
