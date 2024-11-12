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
    let firstVCButton = QFButton(backgroundColor: .systemGreen, title: "N/A")
    let secondVCButton = QFButton(backgroundColor: .systemPurple, title: "N/A")
    let closeButton = QFCloseButton()
    
    
    var firstVC: UIViewController!
    var secondVC: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureUIElements()
        configureButtonActions()
    }
    
    init(description: String, firstVC: UIViewController, firstVCTitle: String, secondVC: UIViewController, secondVCTitle: String) {
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = description
        self.firstVC = firstVC
        self.secondVC = secondVC
        firstVCButton.setTitle(firstVCTitle, for: .normal)
        secondVCButton.setTitle(secondVCTitle, for: .normal)
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
        firstVCButton.addTarget(self, action: #selector(pushListVC), for: .touchUpInside)
        secondVCButton.addTarget(self, action: #selector(pushQuizVC), for: .touchUpInside)
    }
    
    @objc func pushListVC() {
        navigationController?.pushViewController(firstVC, animated: true)
    }
    
    @objc func pushQuizVC() {
        navigationController?.pushViewController(secondVC, animated: true)
    }

    
    func configureUIElements() {
        view.addSubview(containerView)
        view.addSubview(closeButton)
        containerView.addSubview(firstVCButton)
        containerView.addSubview(secondVCButton)
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
            
            
            secondVCButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            secondVCButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            secondVCButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            secondVCButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            firstVCButton.bottomAnchor.constraint(equalTo: secondVCButton.topAnchor, constant: -padding),
            firstVCButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            firstVCButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            firstVCButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            titleLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.bottomAnchor.constraint(equalTo: firstVCButton.topAnchor, constant: -padding)
        ])
    }
    
    @objc func dismissSelectionVC() {
        dismiss(animated: true)
    }
}
