//
//  QFHomeVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 11/09/24.
//

import UIKit

class HomeVC: UIViewController {

    let headerView = UIView()
    let quoteLabel = QFTitleLabel(textAlignment: .center, fontSize: 15)
    let anotherLabel = QFTitleLabel(textAlignment: .center, fontSize: 15)
    let progressView = UIView()
    
    let itemInfoViewOne = QFItemInfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavItem()
        configureHeaderView()
        configureUIElements()
        configureQuoteLabel()
        configureAnotherLabel()
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    @objc func workingButton() {
        print("Working ")
    }
    
    
    func configureNavItem() {
        let configButton = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(workingButton))
        let languageButton = UIBarButtonItem(image: UIImage(systemName: "globe"), style: .plain, target: self, action: #selector(workingButton))
        let flagItem = UIBarButtonItem(customView: QFFrenchFlagView())
        
        configButton.tintColor = .white
        languageButton.tintColor = .white
        
        navigationItem.rightBarButtonItems = [configButton, languageButton]
        navigationItem.leftBarButtonItem = flagItem
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
        quoteLabel.text = "\"Le plus grand risque est de ne prendre aucun risque\" \n- Quelque'un"
        quoteLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        quoteLabel.numberOfLines = 3
        quoteLabel.textColor = .white
        
        
        headerView.addSubview(quoteLabel)
        
        NSLayoutConstraint.activate([
            quoteLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            quoteLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 30),
            quoteLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -30),
        ])
    }
    
    func configureUIElements() {
        self.addChildVC(childVC: QFStreakProgressVC(), in: progressView)
        
        view.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            progressView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -20),
            progressView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            progressView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
            progressView.heightAnchor.constraint(equalToConstant: 40),
            
        ])
        
    }
    
    func configureItemInfoView() {
        view.addSubview(itemInfoViewOne)
        
        NSLayoutConstraint.activate([
            itemInfoViewOne.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            itemInfoViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            itemInfoViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        ])
    }
    
    func configureAnotherLabel() {
        view.addSubview(anotherLabel)
        anotherLabel.text = "Testig something here !!"
        anotherLabel.textColor = .green
        
        NSLayoutConstraint.activate([
            anotherLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 40),
            anotherLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 40),
            anotherLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -40),
        ])
    }
    
    
    func addChildVC(childVC: UIViewController, in containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}
