//  QuizWritingVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 01/11/24.
//

import UIKit

enum QuizSection {
    case main
}

struct TextItem: Identifiable, Hashable {
    var id = UUID()
    var item: String
}


class QuizWriteModeVC: QuizSuperclassVC {
    
    var availableItems: [TextItem] = []
    var usedItems: [TextItem] = []
    
    var answerLabel = QFTitleLabel(textAlignment: .center, fontSize: 24)
    
    
    let undoButton = QFUndoButton()
    
    var collectionViewContainer = UIView()
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<QuizSection, TextItem>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAnswerLabel()
        configureCollectionViewContainer()
        configureCollectionView()
        configureDataSource()
        configureUndoButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        askQuestion()
    }
    
    
    func configureAnswerLabel() {
        view.addSubview(answerLabel)
        // answerLabel.text = "_ _ _ _ _ _"
        answerLabel.numberOfLines = 3
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            answerLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor),
            answerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            answerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            // answerLabel.heightAnchor.constraint(equalToConstant: 44),
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
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createDynamicFlowLayout(in: collectionViewContainer))
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
        var snapshot = NSDiffableDataSourceSnapshot<QuizSection, TextItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(availableItems)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
    
    
    @objc func askQuestion() {
        guard let question = questions.randomElement() else {
            presentCompletedQuizContainer(title: "Congratulations 🥳", message: "You have finished this quiz for now !!", buttonTitle: "Return", navController: self.navigationController!)
            print("No question available")
            
            guard currentLevel < 3 else {
                print("You have completed all levels !")
                return
            }
            
            correctCount = 0
            PersistenceManager.shared.save(quizType: quizType, category: category, currentLevel: currentLevel)
            currentLevel += 1
            return
        }
        
        answerStackView.isHidden = true
        self.currentQuestion = question
        self.questionLabel.text = question.question
        
        activateUndoButton()
        availableItems.removeAll()
        resetState()
        
        switch quizType {
        case "words":
            for character in currentQuestion.correct {
                answerLabel.text! += "_ "
                let letter = TextItem(item: String(character))
                availableItems.append(letter)
                print("Executing words case")
            }
        case "phrases":
            let separatedPhrases = currentQuestion.correct.components(separatedBy: .whitespaces)
            
            for phrase in separatedPhrases {
                answerLabel.text = "_ _ _ _ _ _"
                let phrase = TextItem(item: phrase)
                availableItems.append(phrase)
                print("Executing phrases case")

            }
        default:
            print("Invalid quiz type")
            return
        }
        availableItems = availableItems.shuffled()
        updateLetters() // Snapshot
    }
    
    
    func resetState() {
        answerLabel.text = ""
        answerLabel.textColor = .label
    }
    
    
    func checkAnswer() {
        guard availableItems.isEmpty else {
            print("You still have job to do")
            return
        }
        disableUndoButton()
        
        switch quizType {
        case "words":
            answerView.correctAnswer.text = "\(self.currentQuestion.correct) -"
            answerView.translatedAnswer.text = self.currentQuestion.translation.english
        case "phrases":
            answerView.titleLabel.text = nil
            answerView.correctAnswer.text = "Correct !"
        default:
            break
        }
        
        let formattedAnswer = answerLabel.text?.trimmingCharacters(in: .whitespaces)
        let formattedCorrectAnswer = self.currentQuestion?.correct.trimmingCharacters(in: .whitespaces)
        
        if formattedAnswer == formattedCorrectAnswer {
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
    
    func disableUndoButton() {
        undoButton.removeTarget(self, action: nil, for: .touchUpInside)
    }
    
    func activateUndoButton() {
        undoButton.addTarget(self, action: #selector(undoAnswer), for: .touchUpInside)
    }
    
    
    @objc func undoAnswer() {
        if let lastItem = usedItems.last {
            
            if let range = answerLabel.text?.range(of: lastItem.item, options: .backwards) {
                usedItems.removeLast()
                availableItems.append(lastItem)
                switch quizType {
                case "words":
                    answerLabel.text?.replaceSubrange(range, with: "_ ")
                case "phrases":
                    // Removing the " " space
                    answerLabel.text?.removeLast()
                    // Removing the last selected phrase
                    answerLabel.text?.replaceSubrange(range, with: "")
                default:
                    break
                }
                updateLetters()
                return
            }
        }
        print("Unable to undo")
    }
}

extension QuizWriteModeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = availableItems[indexPath.item]
        let selectedChar = item.item
        let selectedIndex = item.id
        
        usedItems.append(item) // Adding letter to used array
        
        switch quizType {
        case "words":
            if let range = answerLabel.text?.range(of: "_ ") {
                answerLabel.text?.replaceSubrange(range, with: selectedChar)
                availableItems.removeAll(where: { $0.id == selectedIndex })
            }
        case "phrases":
            if let range = answerLabel.text?.range(of: "_ ") {
                answerLabel.text?.removeAll()
            }
            answerLabel.text? += "\(selectedChar) "
            availableItems.removeAll(where: { $0.id == selectedIndex })
        default:
            break
        }
        
        updateLetters()
        
        checkAnswer()
    }
}
