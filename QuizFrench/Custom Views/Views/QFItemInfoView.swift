//
//  QFItemInfoView.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 12/09/24.
//

import UIKit

enum ItemInfoType {
    case alphabets, phrases, words, tips
}

class QFItemInfoView: UIView {
    let symbolImageView = UIImageView()
    let titleLabel = QFTitleLabel(textAlignment: .left, fontSize: 27)
    let bodyLabel = QFSecondaryTitleLabel(fontSize: 18)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(bodyLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .black
        
        titleLabel.textColor = .white
        bodyLabel.textColor = .white
        bodyLabel.numberOfLines = 3
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 70),
            symbolImageView.heightAnchor.constraint(equalToConstant: 70),
            
            titleLabel.topAnchor.constraint(equalTo: symbolImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 25),
            
            bodyLabel.bottomAnchor.constraint(equalTo: symbolImageView.bottomAnchor),
            bodyLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            bodyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bodyLabel.heightAnchor.constraint(equalToConstant: 40),
            
        ])
    }
    
    func set(type: ItemInfoType) {
        switch type {
        case .alphabets:
            symbolImageView.image = UIImage(systemName: SFSymbols.alphabet)
            titleLabel.text = "Alphabet"
            bodyLabel.text = "Start learning the basics"
        case .phrases:
            symbolImageView.image = UIImage(systemName: SFSymbols.phrases)
            titleLabel.text = "Phrases"
            bodyLabel.text = "Practice essential phrases"
        case .words:
            symbolImageView.image = UIImage(systemName: SFSymbols.words)
            titleLabel.text = "Words"
            bodyLabel.text = "Expand your vocabulary"
        case .tips:
            symbolImageView.image = UIImage(systemName: SFSymbols.tips)
            titleLabel.text = "Tips"
            bodyLabel.text = "Quick tips to boost you."
        }
    }
}
