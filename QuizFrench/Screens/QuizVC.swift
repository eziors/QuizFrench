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
    
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        loadData()
        
        configureQuestionLabel()
        configureStackView()
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
        questionLabel.text = "Testing"
        questionLabel.numberOfLines = 2
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            questionLabel.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    func configureStackView() {
        view.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for _ in 0..<4 {
            let button = QFQuizButton(backgroundColor: .systemGray4, title: "Loading")
            button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            answerButtons.append(button)
            stackView.addArrangedSubview(button)
        }
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            stackView.heightAnchor.constraint(equalToConstant: 280),
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
    
    func askQuestion() {
        guard let question = allQuestions.randomElement() else {
            print("Nenhuma pergunta disponível.")
            return
        }
        
        self.currentQuestion = question
        self.questionLabel.text = question.questionText
        
        let options = [question.options.a, question.options.b, question.options.c, question.options.d]
        
        for (index, button) in answerButtons.enumerated() {
            button.setTitle(options[index], for: .normal)
        }
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        guard let selectedOption = sender.title(for: .normal) else { return }
        
        checkAnswer(selectedOption)
    }
    
    
    func checkAnswer(_ selectedOption: String) {
        
        if selectedOption == self.currentQuestion?.correctAnswer {
            print("Correct")
        } else {
            print("Wrong")
        }
        
        askQuestion()
    }
}
