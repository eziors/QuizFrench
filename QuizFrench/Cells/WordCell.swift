//
//  WordCell.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 04/10/24.
//

import UIKit

class WordCell: UITableViewCell {
    
    static let reuseID = "AlphabetCell"
    let mainContainerView = UIView()
    let wordLabel = QFTitleLabel(textAlignment: .left, fontSize: 40)
    
    //let stackView = UIStackView()
    //let playButton = UIButton()
    //let copyButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(word: Word) {
        wordLabel.text = "Testing"
    }
    
    func configureMainContainerView() {
        mainContainerView.backgroundColor = .systemBackground
        mainContainerView.translatesAutoresizingMaskIntoConstraints = false
        mainContainerView.layer.cornerRadius = 12
        mainContainerView.layer.borderWidth = 3
        mainContainerView.layer.borderColor = UIColor.systemGray4.cgColor
    }
    
    private func configure() {
        addSubview(mainContainerView)
        mainContainerView.addSubview(wordLabel)
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            mainContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            mainContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            mainContainerView.heightAnchor.constraint(equalToConstant: 120),
            mainContainerView.widthAnchor.constraint(equalToConstant: 250),
            
            wordLabel.centerYAnchor.constraint(equalTo: mainContainerView.centerYAnchor),
            wordLabel.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor, constant: 10),
            wordLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
}
