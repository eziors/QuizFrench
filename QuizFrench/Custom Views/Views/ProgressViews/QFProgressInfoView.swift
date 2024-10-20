//
//  ProgressInfoView.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 11/09/24.
//

import UIKit

enum QFProgressInfoType {
    case streak, trophy
}

class QFProgressInfoView: UIView {
    
    let progressImageView = UIImageView()
    let progressFirstLabel = QFTitleLabel()
    let progressSecondLabel = QFTitleLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(progressImageView)
        addSubview(progressFirstLabel)
        addSubview(progressSecondLabel)
        
        progressSecondLabel.textColor = .secondaryLabel
        
        progressImageView.translatesAutoresizingMaskIntoConstraints = false
        progressImageView.contentMode = .scaleToFill
        progressImageView.tintColor = .label
        
        NSLayoutConstraint.activate([
            progressImageView.topAnchor.constraint(equalTo: self.topAnchor),
            progressImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            progressImageView.widthAnchor.constraint(equalToConstant: 25),
            progressImageView.heightAnchor.constraint(equalToConstant: 25),
            
            progressFirstLabel.centerYAnchor.constraint(equalTo: progressImageView.centerYAnchor),
            progressFirstLabel.leadingAnchor.constraint(equalTo: progressImageView.trailingAnchor, constant: 8),
            progressFirstLabel.heightAnchor.constraint(equalToConstant: 18),
            
            progressSecondLabel.centerYAnchor.constraint(equalTo: progressFirstLabel.centerYAnchor),
            progressSecondLabel.leadingAnchor.constraint(equalTo: progressFirstLabel.trailingAnchor, constant: 2),
            progressSecondLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            progressSecondLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
    
    func set(progressType: QFProgressInfoType, progressCount: Int) {
        switch progressType {
        case .streak:
            progressImageView.image = UIImage(systemName: "flame.fill")
            progressImageView.tintColor = .red
            progressSecondLabel.text = "/ Days"
        case .trophy:
            progressImageView.image = UIImage(systemName: "trophy.fill")
            progressImageView.tintColor = .systemOrange
            progressSecondLabel.text = "/ Trophies"
        }
        
        progressFirstLabel.text = String(progressCount)
    }
}
