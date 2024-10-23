//
//  QuizVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 11/10/24.
//

import UIKit


class QuizVC: UIViewController {
    
    var quizType: String!
    var category: String!
    
    var allQuestions: [Item.Question] = []
    var questionLevel1: [Item.Question] = []
    var questionsLevel2: [Item.Question] = []
    
    var currentQuestion: Item.Question?
    let questionLabel = QFTitleLabel(textAlignment: .center, fontSize: 22)
    
    var answerButtons: [UIButton] = []
    let buttonsStackView = UIStackView()
    
    let answerView = QFAnswerView()
    let continueButton = QFQuizButton(backgroundColor: .systemGray5, title: "Continue")
    let answerStackView = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        loadData()
        configureAnswerStackView()
        configureQuestionLabel()
        configureButtonsStackView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        askQuestion()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.red]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.red]

        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
    
    func configureQuestionLabel() {
        view.addSubview(questionLabel)
        questionLabel.numberOfLines = 2
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            questionLabel.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    func configureButtonsStackView() {
        view.addSubview(buttonsStackView)
        
        buttonsStackView.axis = .vertical
        buttonsStackView.distribution = .equalCentering
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        for _ in 0..<4 {
            let button = QFQuizButton(backgroundColor: .systemGray5, title: "Loading")
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
    
    
    func configureAnswerStackView() {
        view.addSubview(answerStackView)
        answerStackView.isHidden = true
        answerStackView.axis = .horizontal
        answerStackView.distribution = .equalSpacing
        answerStackView.translatesAutoresizingMaskIntoConstraints = false
        answerStackView.addArrangedSubview(answerView)
        answerStackView.addArrangedSubview(continueButton)
        
        continueButton.addTarget(self, action: #selector(askQuestion), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            answerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            answerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            answerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            continueButton.heightAnchor.constraint(equalToConstant: 44),
            continueButton.widthAnchor.constraint(equalToConstant: 120),
            
        ])
    }
    
    func loadData() {
        NetworkManager.shared.fetchAllItems(itemType: quizType) { items in
            let selectedCategory = self.category
            
            for item in items {
                if item.category == selectedCategory {
                    self.allQuestions = item.questions
                    self.questionLevel1 = Array(self.allQuestions.prefix(10))
                    self.questionsLevel2 = Array(self.allQuestions.suffix(10))
                }
            }
            
            if !self.allQuestions.isEmpty {
                self.askQuestion()
            } else {
                print("Nenhuma pergunta disponível para a categoria \(self.category!)")
            }
        }
    }
    
    @objc func askQuestion() {
        guard let question = allQuestions.randomElement() else {
            print("Nenhuma pergunta disponível.")
            return
        }
        
        answerStackView.isHidden = true
        self.currentQuestion = question
        self.questionLabel.text = question.questionText
        
        let options = [question.options.a, question.options.b, question.options.c, question.options.d]
        
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
        checkAnswer(selectedOption, buttonIndex: buttonIndex)
    }
    
    
    func checkAnswer(_ selectedOption: String, buttonIndex: Int) {
        answerView.correctAnswer.text = self.currentQuestion?.correctAnswer
        
        if selectedOption == self.currentQuestion?.correctAnswer {
            changeAnswerColor(color: UIColor.correctColor, buttonIndex: buttonIndex)
            print("Correct")
        } else {
            changeAnswerColor(color: UIColor.incorrectColor, buttonIndex: buttonIndex)
            print("Wrong")
        }
        answerStackView.isHidden = false
    }
    
    func changeAnswerColor(color: UIColor, buttonIndex: Int) {
        self.answerView.titleLabel.textColor = color
        self.answerView.correctAnswer.textColor = color
        self.continueButton.titleLabel?.textColor = color
        self.answerButtons[buttonIndex].setTitleColor(color, for: .normal)
    }
}