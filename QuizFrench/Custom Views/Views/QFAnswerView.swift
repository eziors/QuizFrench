//
//  QFAnswerView.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 20/10/24.
//

import UIKit

class QFAnswerView: UIView {
    
    let titleLabel = QFBodyLabel(textAlignment: .left)
    let correctAnswer = QFBodyLabel(textAlignment: .left)
    var currentColor: UIColor = .label
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(titleLabel)
        addSubview(correctAnswer)
        
        titleLabel.text = "Correct answer: "
        titleLabel.textColor = currentColor
        correctAnswer.textColor = currentColor
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            correctAnswer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            correctAnswer.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])
    }
}
