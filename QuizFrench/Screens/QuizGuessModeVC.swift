//
//  QuizGuessVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 01/11/24.
//

import UIKit

class QuizGuessModeVC: QuizSuperclassVC {
    
    var answerButtons: [UIButton] = []
    let buttonsStackView = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtonsStackView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        askQuestion()
    }
    
    func configureButtonsStackView() {
        view.addSubview(buttonsStackView)
        
        buttonsStackView.axis = .vertical
        buttonsStackView.distribution = .equalCentering
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        for _ in 0..<4 {
            let button = QFQuizGuessButton(backgroundColor: .systemGray6, title: "Loading")
            button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            answerButtons.append(button)
            buttonsStackView.addArrangedSubview(button)
        }
        
        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 40),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 280),
        ])
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
            ProgressManager.shared.save(quizType: quizType, category: category, currentLevel: currentLevel)
            currentLevel += 1
            return
        }
        
        enableAnswerButtons()
        
        answerStackView.isHidden = true
        self.currentQuestion = question
        self.questionLabel.text = question.question
        
        let options = [question.a, question.b, question.c, question.d]
        
        for (index, button) in answerButtons.enumerated() {
            button.setTitle(options[index], for: .normal)
            button.setTitleColor(.label, for: .normal)
        }
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        var buttonIndex = 0
        
        guard let selectedOption = sender.title(for: .normal) else { return }
        
        for (index, button) in answerButtons.enumerated() {
            if button.currentTitle == selectedOption {
                buttonIndex = index
            }
        }
        
        disableAnswerButtons()
        checkAnswer(selectedOption, buttonIndex: buttonIndex)
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
        self.answerButtons[buttonIndex].setTitleColor(color, for: .normal)
    }
    
    
    func disableAnswerButtons() {
        for button in answerButtons {
            button.removeTarget(self, action: nil, for: .allEvents)
        }
    }
    
    
    func enableAnswerButtons() {
        for button in answerButtons {
            button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        }
    }
    
    override func continueButtonAction() {
        askQuestion()
    }
}
