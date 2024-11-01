//
//  QuizVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 11/10/24.
//

import UIKit


class QuizSuperclassVC: UIViewController {
    
    var quizType: String! // if is words or phrases
    var category: String!
    var currentLevel: Int = 1
    
    var questionsCount = 0
    var correctCount = 0
    
    var questions: [Question] = []
    var currentQuestion: Question!
    
    
    let questionLabel = QFTitleLabel(textAlignment: .center, fontSize: 22)
    let questionCountLabel = QFTitleLabel(textAlignment: .left, fontSize: 20)
    let progressBar = QFProgressBarView()
    
    
    let answerView = QFAnswerView()
    let continueButton = QFQuizGuessButton(backgroundColor: .systemGray6, title: "Continue")
    let answerStackView = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        configureNavigationBar()
        configureQuestionCountLabel()
        configureAnswerStackView()
        configureQuestionLabel()
        configureProgressBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        progressBar.progress = 0
    }
    
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .customPrimary
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        
        navigationItem.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
    }
    
    func loadData() {
        DataManager.shared.getQuizQuestions(for: quizType, category: category, selectedLevel: currentLevel) { result in
            switch result {
            case .success(let questions):
                self.questions = questions
                self.questionsCount = self.questions.count
                self.updateQuestionCountLabel()
            case .failure(let error):
                print("Something went wrong \(error.rawValue)!")
            }
        }
    }
    
    // MARK: --------- UI Funcs ---------
    
    func configureQuestionCountLabel() {
        view.addSubview(questionCountLabel)
        questionCountLabel.numberOfLines = 1
        
        NSLayoutConstraint.activate([
            questionCountLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            questionCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
        ])
    }
    
    func configureProgressBar() {
        view.addSubview(progressBar)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            progressBar.centerYAnchor.constraint(equalTo: questionCountLabel.centerYAnchor),
            progressBar.leadingAnchor.constraint(equalTo: questionCountLabel.trailingAnchor, constant: 10),
            progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            progressBar.heightAnchor.constraint(equalToConstant: 15),
        ])
    }
    
    func updateQuestionCountLabel() {
        self.questionCountLabel.text = "\(self.correctCount) / \(self.questionsCount)"
    }
    
    func configureQuestionLabel() {
        view.addSubview(questionLabel)
        questionLabel.numberOfLines = 2
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: questionCountLabel.bottomAnchor, constant: 30),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            questionLabel.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    
    func configureAnswerStackView() { //MARK:  -------- STAY HERE  --------
        view.addSubview(answerStackView)
        answerStackView.isHidden = true
        answerStackView.axis = .horizontal
        answerStackView.distribution = .equalSpacing
        answerStackView.translatesAutoresizingMaskIntoConstraints = false
        answerStackView.addArrangedSubview(answerView)
        answerStackView.addArrangedSubview(continueButton)
        
        continueButton.addTarget(self, action: #selector(continueButtonAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            answerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            answerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            answerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            continueButton.heightAnchor.constraint(equalToConstant: 44),
            continueButton.widthAnchor.constraint(equalToConstant: 120),
        ])
    }
    
    // MARK: --------- Quiz logic funcs ---------
     
    func updateProgressBar() { //MARK:  -------- STAY HERE  --------
        let progress = Float(correctCount) / Float(questionsCount)
        progressBar.setProgress(progress, animated: true)
    }
    
    @objc func continueButtonAction() { }
}


/* ---------- Deprecated ----------
func loadData() {
    DataManager.shared.fetchAllItems(itemType: quizType) { items in
        let selectedCategory = self.category
        
        for item in items {
            if item.category == selectedCategory {
                self.allQuestions = item.questions
                self.questionLevel1 = Array(self.allQuestions.prefix(10))
                self.questionsLevel2 = Array(self.allQuestions.suffix(10))
            }
        }
        
        if !self.allQuestions.isEmpty {
            self.questionsCount = self.allQuestions.count
            self.updateQuestionCountLabel()
            self.askQuestion()
        } else {
            print("Nenhuma pergunta disponível para a categoria \(self.category!)")
        }
    }
}
*/

