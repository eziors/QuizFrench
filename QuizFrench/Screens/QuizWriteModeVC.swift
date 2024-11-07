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
    
    var availableLetters: [Letter] = []
    var usedLetters: [Letter] = []
    
    var answerLabel = QFTitleLabel(textAlignment: .center, fontSize: 24)
    
    
    let undoButton = QFUndoButton()
    
    var collectionViewContainer = UIView()
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<QuizSection, Letter>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAnswerLabel()
        configureCollectionViewContainer()
        configureCollectionView()
        configureDataSource()
        configureUndoButton()
        
        questionInfoLabel.text = "Translate this word:"
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
        collectionViewContainer.translatesAutoresizingMaskIntoConstraints = false
        collectionViewContainer.frame = view.bounds
        
        NSLayoutConstraint.activate([
            collectionViewContainer.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 20),
            collectionViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            collectionViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            collectionViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -180),
        ])
    }
    
    
    
        
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createFiveColumnFlowLayout(in: collectionViewContainer))
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
    

    func configureUndoButton() {
        view.addSubview(undoButton)
        undoButton.addTarget(self, action: #selector(undoAnswer), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            undoButton.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 20),
            undoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
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
        snapshot.appendItems(availableLetters)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
    
    
    @objc func askQuestion() {
        guard let question = questions.randomElement() else {
            presentCompletedQuizContainer(title: "Congratulations 🥳", message: "You have finished this quiz for now !!", buttonTitle: "Return", navController: self.navigationController!)
            print("No question available")
            return
        }
        
        answerStackView.isHidden = true
        self.currentQuestion = question
        self.questionLabel.text = question.question
        
        availableLetters.removeAll()
        resetState()
        
        for character in currentQuestion.correct {
            answerLabel.text! += "_ "
            let letter = Letter(letter: String(character))
            availableLetters.append(letter)
        }
        availableLetters = availableLetters.shuffled()
        
        updateLetters() // Snapshot
    }
    
    
    func resetState() {
        answerLabel.text = ""
        answerLabel.textColor = .label
    }
    
    
    func checkAnswer() {
        guard availableLetters.isEmpty else {
            print("You still have job to do")
            return
        }
        answerView.correctAnswer.text = "\(self.currentQuestion.correct) -"
        answerView.translatedAnswer.text = self.currentQuestion.translation.english
        
        if answerLabel.text == self.currentQuestion?.correct {
            changeAnswerColor(color: UIColor.correctColor)
            correctCount += 1
            self.questions.removeAll(where: { $0.id == currentQuestion?.id })
        } else {
            changeAnswerColor(color: UIColor.incorrectColor)
        }
        answerStackView.isHidden = false
        updateQuestionCountLabel()
        updateProgressBar()
    }
    
    
    func changeAnswerColor(color: UIColor) {
        self.answerView.titleLabel.textColor = color
        self.answerView.translatedAnswer.textColor = color
        self.answerLabel.textColor = color
        self.answerView.correctAnswer.textColor = color
        self.continueButton.titleLabel?.textColor = color
    }
    
    
    override func continueButtonAction() {
        askQuestion()
    }
    
    
    @objc func undoAnswer() {
        if let lastChar = usedLetters.last {
            if let range = answerLabel.text?.range(of: lastChar.letter, options: .backwards) {
                usedLetters.removeLast()
                availableLetters.append(lastChar)
                answerLabel.text?.replaceSubrange(range, with: "_ ")
                updateLetters()
                return
            }
        }
        print("Unable to undo")
    }
}

extension QuizWriteModeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = availableLetters[indexPath.item]
        let selectedChar = item.letter
        let selectedIndex = item.id
        
        usedLetters.append(item) // Adding letter to used array
        
        if let range = answerLabel.text?.range(of: "_ ") {
            answerLabel.text?.replaceSubrange(range, with: selectedChar)
            availableLetters.removeAll(where: { $0.id == selectedIndex })
        }
        updateLetters()
        
        checkAnswer()
    }
}
