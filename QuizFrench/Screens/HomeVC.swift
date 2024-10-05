//
//  HomeVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 11/09/24.
//

import UIKit
import AVFoundation
import Firebase

protocol QFHomeVCDelegate: class {
    func didTapAlphabet()
    func didTapWords()
    func didTapPhrases()
    func didTapTips()
}

class HomeVC: UIViewController {

    let headerView = UIView()
    let anotherLabel = QFTitleLabel(textAlignment: .center, fontSize: 15)
    let itemInfoViewOne = UIView()
    let itemInfoViewTwo = UIView()
    let itemInfoViewThree = UIView()
    let itemInfoViewFour = UIView()
    
    var itemInfoViews = [UIView]()
    
    var player = AVAudioPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavItem()
        configureUIElements()
        layoutUI()
        
        NetworkManager.shared.fetchAllItems { items in
            print(items[0])
            
        }
    }

    

    @objc func playRemoteAudio() {
        
        guard let url = URL(string: "https://webaudioapi.com/samples/audio-tag/chrono.mp3") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error != nil {
                print("Failed to download audio: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Failed to download audio: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            guard let data = data else {
                print("Failed to download audio: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            
            DispatchQueue.main.async {
                do {
                    self.player = try AVAudioPlayer(data: data)
                    self.player.play()
                } catch {
                    print("Error playing remote audio: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    @objc func pushWordListVC() {
        let wordListVC = WordListVC()
        wordListVC.title = "Numbers"
        
        navigationController?.pushViewController(wordListVC, animated: true)
    }
    
    
    func configureNavItem() {
        let configButton = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(pushWordListVC))
        let languageButton = UIBarButtonItem(image: UIImage(systemName: "globe"), style: .plain, target: self, action: #selector(playRemoteAudio))
        let flagItem = UIBarButtonItem(customView: QFFrenchFlagView())
        
        configButton.tintColor = .white
        languageButton.tintColor = .white
        
        navigationItem.rightBarButtonItems = [configButton, languageButton]
        navigationItem.leftBarButtonItem = flagItem
    }
    
    
    
    func configureUIElements() {
        let alphabetItemVC = QFAlphabetItemVC()
        alphabetItemVC.delegate = self
        
        let wordItemVC = QFWordsItemVC()
        wordItemVC.delegate = self
        
        let phrasesItemVC = QFPhrasesItemVC()
        phrasesItemVC.delegate = self
        
        let tipsItemVC = QFTipsItemVC()
        tipsItemVC.delegate = self
        
        self.addChildVC(childVC: QFHomeHeaderVC(), in: headerView)
        self.addChildVC(childVC: alphabetItemVC, in: itemInfoViewOne)
        self.addChildVC(childVC: wordItemVC, in: itemInfoViewTwo)
        self.addChildVC(childVC: phrasesItemVC, in: itemInfoViewThree)
        self.addChildVC(childVC: tipsItemVC, in: itemInfoViewFour)
        
    }
    
    func layoutUI() {
        let padding: CGFloat = 20
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        itemInfoViews = [itemInfoViewOne, itemInfoViewTwo, itemInfoViewThree, itemInfoViewFour]
        
        for itemInfoView in itemInfoViews {
            view.addSubview(itemInfoView)
            itemInfoView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
 
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 300),
            
            itemInfoViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemInfoViewOne.heightAnchor.constraint(equalToConstant: 95),
            
            itemInfoViewTwo.topAnchor.constraint(equalTo: itemInfoViewOne.bottomAnchor, constant: padding),
            itemInfoViewTwo.heightAnchor.constraint(equalToConstant: 95),
            
            itemInfoViewThree.topAnchor.constraint(equalTo: itemInfoViewTwo.bottomAnchor, constant: padding),
            itemInfoViewThree.heightAnchor.constraint(equalToConstant: 95),
            
            itemInfoViewFour.topAnchor.constraint(equalTo: itemInfoViewThree.bottomAnchor, constant: padding),
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

extension HomeVC: QFHomeVCDelegate {
    func didTapAlphabet() {
        let alphabetVC = AlphabetListVC()
        alphabetVC.title = "Alphabet"
        navigationController?.pushViewController(alphabetVC, animated: true)
    }
    
    func didTapWords() {
        let wordsCategoryVC = WordsCategoriesVC()
        wordsCategoryVC.title = "Words"
        navigationController?.pushViewController(wordsCategoryVC, animated: true)
    }
    
    func didTapPhrases() {
        print("Phrases working !")
    }
    
    func didTapTips() {
        print("Tips working !")
    }
    
    
}
