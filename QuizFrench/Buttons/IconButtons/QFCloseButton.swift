//
//  QFCloseButton.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 15/10/24.
//

import UIKit

class QFCloseButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        let buttonSizeConfig = UIImage.SymbolConfiguration(pointSize: 100, weight: .light, scale: .default)
        let playButtonIcon = UIImage(systemName: "x.circle.fill", withConfiguration: buttonSizeConfig)
        playButtonIcon?.withTintColor(.yellow)
        
        backgroundColor = .white
        contentMode = .scaleToFill
        layer.borderWidth = 3
        layer.cornerRadius = 25
        layer.borderColor = UIColor.white.cgColor
        clipsToBounds = true
        tintColor = .systemRed
        setImage(playButtonIcon, for: .normal)
    }
}
