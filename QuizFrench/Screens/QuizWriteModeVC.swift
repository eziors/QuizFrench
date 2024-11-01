//
//  QuizWritingVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 01/11/24.
//

import UIKit

class QuizWriteModeVC: QuizSuperclassVC {
    
    var letterButtons: [UIButton] = []
    var buttonsStackView = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtonsStackView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        askQuestion()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        removeSubViews()
    }
    
    func configureButtonsStackView() {
        view.addSubview(buttonsStackView)
        
        buttonsStackView.axis = .horizontal
        buttonsStackView.distribution = .equalCentering
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        /*
        for letter in currentQuestion.question {
            let button = QFQuizButton(backgroundColor: .systemGray6, title: "Loading")
            button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            answerButtons.append(button)
            buttonsStackView.addArrangedSubview(button)
        }
        */
        
        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 40),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc func askQuestion() {
        var letters: [String] = []
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
        
        for letter in letters {
            let button = QFQuizWriteButton(title: "\(letter)")
            button.setTitle("\(letter)", for: .normal)
            buttonsStackView.addArrangedSubview(button)

        }
        
        
        /*
        for (index, button) in answerButtons.enumerated() {
            button.setTitle(options[index], for: .normal)
            button.setTitleColor(.label, for: .normal)
        }
         */
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
        for i in self.buttonsStackView.arrangedSubviews {
            self.buttonsStackView.removeArrangedSubview(i)
        }
    }
}
