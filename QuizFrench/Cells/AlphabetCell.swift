//
//  AlphabetCell.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 20/09/24.
//

import UIKit

class AlphabetCell: UICollectionViewCell {
    
    static let reuseID = "AlphabetCell"
    let mainContainerView = UIView()
    let footerContainerView = UIView()
    let alphabetLabel = QFTitleLabel(textAlignment: .center, fontSize: 40)
    
    let stackView = UIStackView()
    let playButton = UIButton()
    let copyButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMainContainerView()
        configureButtons()
        configureFooterContainerView()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(alphabetLetter: String) {
        alphabetLabel.text = alphabetLetter
    }
    
    func configureMainContainerView() {
        mainContainerView.backgroundColor = .systemRed
        mainContainerView.translatesAutoresizingMaskIntoConstraints = false
        mainContainerView.layer.cornerRadius = 12
        mainContainerView.layer.borderWidth = 3
        mainContainerView.layer.borderColor = UIColor.systemGray4.cgColor
        mainContainerView.clipsToBounds = true
    }
    
    func configureFooterContainerView() {
        footerContainerView.backgroundColor = .systemBlue
        footerContainerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureButtons() {
        
        playButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        playButton.contentMode = .scaleToFill
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.tintColor = .white
        
        
        copyButton.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        copyButton.translatesAutoresizingMaskIntoConstraints = false
        copyButton.contentMode = .scaleToFill
        copyButton.tintColor = .white
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(playButton)
        stackView.addArrangedSubview(copyButton)
        
    }
    
    private func configure() {
        addSubview(mainContainerView)
        mainContainerView.addSubview(alphabetLabel)
        mainContainerView.addSubview(footerContainerView)
        
        footerContainerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 8
        let buttonSize: CGFloat = 60
        
        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            mainContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            mainContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            mainContainerView.heightAnchor.constraint(equalToConstant: 180),
            mainContainerView.widthAnchor.constraint(equalToConstant: 100),
            
            footerContainerView.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor),
            footerContainerView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            footerContainerView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            footerContainerView.heightAnchor.constraint(equalToConstant: 60),
            
            alphabetLabel.centerXAnchor.constraint(equalTo: mainContainerView.centerXAnchor),
            alphabetLabel.centerYAnchor.constraint(equalTo: mainContainerView.centerYAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: footerContainerView.topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: footerContainerView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: footerContainerView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: footerContainerView.bottomAnchor, constant: -5),
            
            
            playButton.widthAnchor.constraint(equalToConstant: buttonSize),
            playButton.heightAnchor.constraint(equalToConstant: buttonSize),
                    
            copyButton.widthAnchor.constraint(equalToConstant: buttonSize),
            copyButton.heightAnchor.constraint(equalToConstant: buttonSize),
            
        ])
    }
}

