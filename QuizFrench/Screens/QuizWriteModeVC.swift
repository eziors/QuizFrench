//
//  QuizWritingVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 01/11/24.
//

import UIKit

class QuizWriteModeVC: QuizSuperclassVC {
    
    var letterButtons: [UIButton] = []
    var buttonsStackViewOne = UIStackView()
    var buttonsStackViewTwo = UIStackView()
    
    
    var answerLabel = QFTitleLabel(textAlignment: .center, fontSize: 22)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAnswerLabel()
        configureButtonsStackView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        askQuestion()
    }
    
    func configureAnswerLabel() {
        view.addSubview(answerLabel)
        answerLabel.text = ""
        
        NSLayoutConstraint.activate([
            answerLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor),
            answerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            answerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            answerLabel.heightAnchor.constraint(equalToConstant: 44),
            
        ])
    }
    
    
    func configureButtonsStackView() {
        view.addSubview(buttonsStackViewOne)
        view.addSubview(buttonsStackViewTwo)
        
        buttonsStackViewOne.axis = .horizontal
        buttonsStackViewOne.distribution = .equalSpacing
        buttonsStackViewOne.spacing = 10
        buttonsStackViewOne.translatesAutoresizingMaskIntoConstraints = false
        
        
        buttonsStackViewTwo.axis = .horizontal
        buttonsStackViewTwo.distribution = .equalSpacing
        buttonsStackViewTwo.spacing = 10
        buttonsStackViewTwo.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        /*
        for letter in currentQuestion.question {
            let button = QFQuizButton(backgroundColor: .systemGray6, title: "Loading")
            button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            answerButtons.append(button)
            buttonsStackView.addArrangedSubview(button)
        }
        */
        
        NSLayoutConstraint.activate([
            buttonsStackViewOne.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 40),
            buttonsStackViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            buttonsStackViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            buttonsStackViewOne.heightAnchor.constraint(equalToConstant: 40),
            
            buttonsStackViewTwo.topAnchor.constraint(equalTo: buttonsStackViewOne.bottomAnchor, constant: 10),
            buttonsStackViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            buttonsStackViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            buttonsStackViewTwo.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc func askQuestion() {
        var letters: [String] = []
        var letterCount: Int = letters.count
        
        var addedCount: Int = 0
        guard let question = questions.randomElement() else {
            presentCompletedQuizContainer(title: "Congratulations 🥳", message: "You have finished this quiz for now !!", buttonTitle: "Return", navController: self.navigationController!)
            
            print("Nenhuma pergunta disponível.")
            return
        }
        
        
        answerStackView.isHidden = true
        self.currentQuestion = question
        self.questionLabel.text = question.question
        
        for letter in currentQuestion.correct { letters.append("\(letter)") }
        letters = letters.shuffled()
        
        resetState()
        
        for letter in letters {
            let button = QFQuizWriteButton(title: String(letter))
            button.setTitle(String(letter), for: .normal)
            
            addedCount += 1
            answerLabel.text! += "_ "
            if addedCount < 6 {
                buttonsStackViewOne.addArrangedSubview(button)
            } else {
                buttonsStackViewTwo.addArrangedSubview(button)
            }
                    }
        
        
        /*
        for (index, button) in answerButtons.enumerated() {
            button.setTitle(options[index], for: .normal)
            button.setTitleColor(.label, for: .normal)
        }
         */
    }
    
    func resetState() {
        buttonsStackViewOne.arrangedSubviews.forEach { $0.removeFromSuperview() }
        buttonsStackViewTwo.arrangedSubviews.forEach { $0.removeFromSuperview() }
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
    
    func removeSubViews() {
        for i in self.buttonsStackViewOne.arrangedSubviews {
            self.buttonsStackViewOne.removeArrangedSubview(i)
        }
    }
}
