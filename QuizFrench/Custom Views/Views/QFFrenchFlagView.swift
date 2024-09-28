//
//  QFFrenchFlagView.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 11/09/24.
//

import UIKit

class QFFrenchFlagView: UIView {
    
    let flagImageView = UIImageView()
    let flagImageLabel = QFTitleLabel(textAlignment: .left, fontSize: 20)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(flagImageView)
        addSubview(flagImageLabel)
        
        flagImageView.image = UIImage(named: "france-flag")
        flagImageView.contentMode = .scaleAspectFit
        flagImageView.translatesAutoresizingMaskIntoConstraints = false
        
        flagImageLabel.text = "French"
        flagImageLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            flagImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            flagImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            flagImageView.widthAnchor.constraint(equalToConstant: 40),
            flagImageView.heightAnchor.constraint(equalToConstant: 30),
            
            flagImageLabel.leadingAnchor.constraint(equalTo: flagImageView.trailingAnchor, constant: 8),
            flagImageLabel.centerYAnchor.constraint(equalTo: flagImageView.centerYAnchor),
            flagImageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
