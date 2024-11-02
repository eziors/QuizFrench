//  QuizWritingVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 01/11/24.
//

import UIKit

enum QuizSection {
    case main
}

struct Letter: Identifiable, Hashable {
    var id = UUID()
    var letter: String
}

class QuizWriteModeVC: QuizSuperclassVC {
    
    var letters: [Letter] = []
    var answerLabel = QFTitleLabel(textAlignment: .center, fontSize: 22)
    
    var collectionViewContainer = UIView()
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<QuizSection, Letter>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionViewContainer()
        configureCollectionView()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        askQuestion()
    }
    
    
    func configureAnswerLabel() {
        view.addSubview(answerLabel)
        answerLabel.text = ""
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            answerLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor),
            answerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            answerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            answerLabel.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    func configureCollectionViewContainer() {
        view.addSubview(collectionViewContainer)
        collectionViewContainer.backgroundColor = UIColor.white.withAlphaComponent(0)
        collectionViewContainer.translatesAutoresizingMaskIntoConstraints = false
        collectionViewContainer.frame = view.bounds
        
        
        NSLayoutConstraint.activate([
            collectionViewContainer.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20),
            collectionViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            collectionViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            collectionViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -180),
            
        ])
    }
    
        
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createFiveColumnFlowLayout())
        collectionViewContainer.addSubview(collectionView)
        collectionView.backgroundColor = UIColor.white.withAlphaComponent(0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.frame = view.bounds
        
        collectionView.delegate = self
        collectionView.register(QuizCell.self, forCellWithReuseIdentifier: QuizCell.reuseID)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: collectionViewContainer.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: collectionViewContainer.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: collectionViewContainer.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: collectionViewContainer.bottomAnchor)
        ])
    }
    
    func createFiveColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width = collectionViewContainer.bounds.width
        let padding: CGFloat = 10
        let itemSpacing: CGFloat = 20
        let availableWidth = width - (padding * 4) - (itemSpacing * 4)
        let itemWidth = availableWidth / 5
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth , height: itemWidth )
        return flowLayout
    }

    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, letter in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizCell.reuseID, for: indexPath) as! QuizCell
            cell.set(for: letter)
            return cell
        })
    }
    
    func updateLetters() {
        var snapshot = NSDiffableDataSourceSnapshot<QuizSection, Letter>()
        snapshot.appendSections([.main])
        snapshot.appendItems(letters)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    @objc func askQuestion() {
        guard let question = questions.randomElement() else {
            presentCompletedQuizContainer(title: "Congratulations 🥳", message: "You have finished this quiz for now !!", buttonTitle: "Return", navController: self.navigationController!)
            print("Nenhuma pergunta disponível.")
            return
        }
        
        answerStackView.isHidden = true
        self.currentQuestion = question
        self.questionLabel.text = question.question
        
        letters.removeAll() // Limpa a lista de letras antes de adicionar novas
        for character in currentQuestion.correct {
            //answerLabel.text! += "_ "
            let letter = Letter(letter: String(character))
            letters.append(letter)
        }
        letters = letters.shuffled()
        
        updateLetters()
        print(currentQuestion)
        resetState()
    }
    
    func resetState() {
        answerLabel.text = ""
    }
    
    func checkAnswer(_ selectedOption: String, buttonIndex: Int) {
        answerView.correctAnswer.text = self.currentQuestion?.correct
        
        if selectedOption == self.currentQuestion?.correct {
            changeAnswerColor(color: UIColor.correctColor, buttonIndex: buttonIndex)
            correctCount += 1
            self.questions.removeAll(where: { $0.id == currentQuestion?.id })
        } else {
            changeAnswerColor(color: UIColor.incorrectColor, buttonIndex: buttonIndex)
        }
        answerStackView.isHidden = false
        updateQuestionCountLabel()
        updateProgressBar()
    }
    
    func changeAnswerColor(color: UIColor, buttonIndex: Int) {
        self.answerView.titleLabel.textColor = color
        self.answerView.correctAnswer.textColor = color
        self.continueButton.titleLabel?.textColor = color
    }
    
    override func continueButtonAction() {
        askQuestion()
    }
}

extension QuizWriteModeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = letters[indexPath.item]
        print(item)
    }
}

//MARK: ------- BACKUP --------

/*
 func createFiveColumnFlowLayout() -> UICollectionViewFlowLayout {
     let width = collectionViewContainer.bounds.width
     let padding: CGFloat = 10
     let itemSpacing: CGFloat = 30
     let availableWidth = width - (padding * 4) - (itemSpacing * 4)
     let itemWidth = availableWidth / 5
     
     let flowLayout = UICollectionViewFlowLayout()
     flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
     flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
     return flowLayout
 }

 */
