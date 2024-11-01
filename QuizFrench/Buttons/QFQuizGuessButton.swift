//
//  QFQuizButton.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 20/10/24.
//

import UIKit

class QFQuizGuessButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
        configure()
    }
    
    func setLabelColor(color: UIColor) {
        self.setTitleColor(color, for: .normal)
    }
    
    func configure() {
        layer.cornerRadius = 25
        setTitleColor(.label, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 2
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
