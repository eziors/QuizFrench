//
//  QFFavoriteButton.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 04/10/24.
//

import UIKit

class QFFavoriteButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        let buttonSizeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .light, scale: .default)
        let playButtonIcon = UIImage(systemName: "star", withConfiguration: buttonSizeConfig)
        playButtonIcon?.withTintColor(.yellow)
        
        self.contentMode = .scaleToFill
        self.tintColor = .systemYellow
        self.setImage(playButtonIcon, for: .normal)
    }
}
