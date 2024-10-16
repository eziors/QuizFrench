//
//  QFSelectionVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 15/10/24.
//

import UIKit

class QFSelectionVC: UIViewController {

    let containerView = UIView()
    let titleLabel = QFTitleLabel(textAlignment: .center, fontSize: 22)
    let practiceButton = QFButton(backgroundColor: .systemGreen, title: "Practice")
    let quizButton = QFButton(backgroundColor: .systemPurple, title: "Start Quiz")
    let closeButton = QFCloseButton()
    
    
    var selectedVC: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureUIElements()
        configureButtonActions()
    }
    
    init(title: String, for viewController: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = title
        selectedVC = viewController
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContainerView() {
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        
    }
    
    func configureButtonActions() {
        closeButton.addTarget(self, action: #selector(dismissSelectionVC), for: .touchUpInside)
        practiceButton.addTarget(self, action: #selector(pushSelectedVC), for: .touchUpInside)
    }
    
    @objc func pushSelectedVC() {
        navigationController?.pushViewController(selectedVC, animated: true)
    }

    
    func configureUIElements() {
        view.addSubview(containerView)
        view.addSubview(closeButton)
        containerView.addSubview(practiceButton)
        containerView.addSubview(quizButton)
        containerView.addSubview(titleLabel)
        
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        
        titleLabel.textColor = UIColor.black
        
        let padding: CGFloat = 14
                
        NSLayoutConstraint.activate([
            
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 220),
            containerView.widthAnchor.constraint(equalToConstant: 260),
            
            
            closeButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: -25),
            closeButton.widthAnchor.constraint(equalToConstant: 50),
            closeButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            quizButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            quizButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            quizButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            quizButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            practiceButton.bottomAnchor.constraint(equalTo: quizButton.topAnchor, constant: -padding),
            practiceButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            practiceButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            practiceButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            titleLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.bottomAnchor.constraint(equalTo: practiceButton.topAnchor, constant: -padding)
        ])
    }
    
    @objc func dismissSelectionVC() {
        dismiss(animated: true)
    }
}
