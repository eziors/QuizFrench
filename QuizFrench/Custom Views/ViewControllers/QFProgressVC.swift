//
//  QFProgressVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 11/09/24.
//

import UIKit

class QFProgressVC: UIViewController {

    let stackView = UIStackView()
    let progressViewOne = QFProgressInfoView()
    let progressViewTwo = QFProgressInfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        configureStackView()
        layoutUI()
    }
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemGray5
        
    }
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(progressViewOne)
        stackView.addArrangedSubview(progressViewTwo)
    }
    
    private func layoutUI() {
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
        ])
    }
}
