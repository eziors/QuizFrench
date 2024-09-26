//
//  QFHomeVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 11/09/24.
//

import UIKit

class HomeVC: UIViewController {

    let headerView = UIView()
    let anotherLabel = QFTitleLabel(textAlignment: .center, fontSize: 15)
    let itemInfoViewOne = UIView()
    let itemInfoViewTwo = UIView()
    let itemInfoViewThree = UIView()
    let itemInfoViewFour = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavItem()
        configureUIElements()
    }

    
    @objc func workingButton() {
        print("Working ")
    }
    
    @objc func pushAlphabetVC() {
        let alphabetVC = AlphabetListVC()
        alphabetVC.title = "Alphabet"
        
        navigationController?.pushViewController(alphabetVC, animated: true)
    }
    
    
    func configureNavItem() {
        let configButton = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(pushAlphabetVC))
        let languageButton = UIBarButtonItem(image: UIImage(systemName: "globe"), style: .plain, target: self, action: #selector(workingButton))
        let flagItem = UIBarButtonItem(customView: QFFrenchFlagView())
        
        configButton.tintColor = .white
        languageButton.tintColor = .white
        
        navigationItem.rightBarButtonItems = [configButton, languageButton]
        navigationItem.leftBarButtonItem = flagItem
    }
    
    
    
    func configureUIElements() {
        let alphabetItemVC = QFAlphabetItemVC()
        let wordItemVC = QFWordsItemVC()
        let phrasesItemVC = QFPhrasesItemVC()
        let tipsItemVC = QFTipsItemVC()
        
        self.addChildVC(childVC: QFHomeHeaderVC(), in: headerView)
        self.addChildVC(childVC: alphabetItemVC, in: itemInfoViewOne)
        self.addChildVC(childVC: wordItemVC, in: itemInfoViewTwo)
        self.addChildVC(childVC: phrasesItemVC, in: itemInfoViewThree)
        self.addChildVC(childVC: tipsItemVC, in: itemInfoViewFour)
        
        view.addSubview(headerView)
        view.addSubview(itemInfoViewOne)
        view.addSubview(itemInfoViewTwo)
        view.addSubview(itemInfoViewThree)
        view.addSubview(itemInfoViewFour)
        
        let padding: CGFloat = 20
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        itemInfoViewOne.translatesAutoresizingMaskIntoConstraints = false
        itemInfoViewTwo.translatesAutoresizingMaskIntoConstraints = false
        itemInfoViewThree.translatesAutoresizingMaskIntoConstraints = false
        itemInfoViewFour.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 300),
            
            itemInfoViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemInfoViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemInfoViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemInfoViewOne.heightAnchor.constraint(equalToConstant: 95),
            
            itemInfoViewTwo.topAnchor.constraint(equalTo: itemInfoViewOne.bottomAnchor, constant: padding),
            itemInfoViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemInfoViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemInfoViewTwo.heightAnchor.constraint(equalToConstant: 95),
            
            itemInfoViewThree.topAnchor.constraint(equalTo: itemInfoViewTwo.bottomAnchor, constant: padding),
            itemInfoViewThree.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemInfoViewThree.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemInfoViewThree.heightAnchor.constraint(equalToConstant: 95),
            
            itemInfoViewFour.topAnchor.constraint(equalTo: itemInfoViewThree.bottomAnchor, constant: padding),
            itemInfoViewFour.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemInfoViewFour.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemInfoViewFour.heightAnchor.constraint(equalToConstant: 95),
        ])
    }
    
    
    func addChildVC(childVC: UIViewController, in containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}
