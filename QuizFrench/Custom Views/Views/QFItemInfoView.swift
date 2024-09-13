//
//  QFItemInfoView.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 12/09/24.
//

import UIKit

class QFItemInfoView: UIView {
    
    let iconContainer = UIView()
    let messageContainer = UIView()
    let iconImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(iconContainer)
        addSubview(messageContainer)
        
        iconContainer.backgroundColor = .systemGreen
        messageContainer.backgroundColor = .systemBlue
        
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        messageContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconContainer.topAnchor.constraint(equalTo: self.topAnchor),
            iconContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            iconContainer.heightAnchor.constraint(equalToConstant: 90),
            iconContainer.widthAnchor.constraint(equalToConstant: 90),
            
            messageContainer.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            messageContainer.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor),
            messageContainer.heightAnchor.constraint(equalToConstant: 90),
            messageContainer.widthAnchor.constraint(equalToConstant: 180),
        ])
        
    }
}
