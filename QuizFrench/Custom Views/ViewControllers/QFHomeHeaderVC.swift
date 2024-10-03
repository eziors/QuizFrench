//
//  QFHomeHeaderVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 13/09/24.
//

import UIKit

class QFHomeHeaderVC: UIViewController {
    
    let headerView = UIView()
    let quoteLabel = QFTitleLabel(textAlignment: .center, fontSize: 15)
    let progressView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureQuoteLabel()
        configureUIElements()
        
        view.backgroundColor = UIColor(red: 0.23, green: 0.23, blue: 0.24, alpha: 1.00)
    }
    
    
    func configureHeaderView() {
        view.addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = UIColor(red: 0.23, green: 0.23, blue: 0.24, alpha: 1.00)
        
        let screenWidth = view.frame.width
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 330),
            headerView.widthAnchor.constraint(equalToConstant: screenWidth),
        ])
    }
    
    func configureQuoteLabel() {
        view.addSubview(quoteLabel)

        quoteLabel.text = "\"Le plus grand risque est de ne prendre aucun risque\" \n- Quelque'un"
        quoteLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        quoteLabel.numberOfLines = 3
        quoteLabel.textColor = .white
        
        
        NSLayoutConstraint.activate([
            quoteLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            quoteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            quoteLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }
    
    func configureUIElements() {
        self.addChildVC(childVC: QFStreakProgressVC(), in: progressView)
        
        view.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            progressView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            progressView.heightAnchor.constraint(equalToConstant: 40),
            
        ])
    }
    
   
    
    func addChildVC(childVC: UIViewController, in containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
}