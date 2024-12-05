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
        offState()
        self.contentMode = .scaleToFill
        self.tintColor = .systemYellow
    }
    
    func offState() {
        let playButtonIcon = UIImage(systemName: "star", withConfiguration: UIImage.SymbolConfiguration.defaultButtonSize)
        playButtonIcon?.withTintColor(.yellow)
        self.setImage(playButtonIcon, for: .normal)
    }
    
    func onState() {
        let playButtonIcon = UIImage(systemName: "star.fill", withConfiguration: UIImage.SymbolConfiguration.defaultButtonSize)
        playButtonIcon?.withTintColor(.yellow)
        self.setImage(playButtonIcon, for: .normal)
    }
}
