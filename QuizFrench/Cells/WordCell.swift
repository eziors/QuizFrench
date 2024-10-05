import UIKit

class WordCell: UITableViewCell {
    
    static let reuseID = "WordCell"
    let mainContainerView = UIView()
    let wordLabel = QFTitleLabel(textAlignment: .left, fontSize: 22)
    let translatedWordLabel = QFSecondaryTitleLabel(fontSize: 18)
    
    let stackView = UIStackView()
    
    let playButton = QFPlayButton()
    let copyButton = QFCopyButton()
    let favoriteButton = QFFavoriteButton()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUIElements()
        configureMainContainerView()
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(word: Word.Question) {
        wordLabel.text = word.correctAnswer
        translatedWordLabel.text = word.correctAnswer

    }
    
    
    private func configureMainContainerView() {
        mainContainerView.backgroundColor = .systemBackground
        mainContainerView.translatesAutoresizingMaskIntoConstraints = false
        mainContainerView.layer.cornerRadius = 12
        mainContainerView.layer.borderWidth = 2
        mainContainerView.layer.borderColor = UIColor.systemGray4.cgColor
        mainContainerView.layer.shadowColor = UIColor.black.cgColor
        mainContainerView.layer.shadowOpacity = 0.1
        mainContainerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        mainContainerView.layer.shadowRadius = 4
    }
    
    
    private func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(playButton)
        stackView.addArrangedSubview(copyButton)
        stackView.addArrangedSubview(favoriteButton)
        stackView.setCustomSpacing(15, after: playButton)
        
        let buttonSize: CGFloat = 25
        
        NSLayoutConstraint.activate([
            playButton.heightAnchor.constraint(equalToConstant: buttonSize),
            playButton.widthAnchor.constraint(equalToConstant: buttonSize),
            
            copyButton.heightAnchor.constraint(equalToConstant: buttonSize),
            copyButton.widthAnchor.constraint(equalToConstant: buttonSize),
            
            favoriteButton.heightAnchor.constraint(equalToConstant: buttonSize),
            favoriteButton.widthAnchor.constraint(equalToConstant: buttonSize)
        ])
    }
    
    private func configureUIElements() {
        contentView.addSubview(mainContainerView)
        mainContainerView.addSubview(wordLabel)
        mainContainerView.addSubview(translatedWordLabel)
        mainContainerView.addSubview(stackView)
        
        self.selectionStyle = .none
        
        let padding: CGFloat = 12
        let contentPadding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            mainContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            mainContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            mainContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            
            
            wordLabel.topAnchor.constraint(equalTo: mainContainerView.topAnchor, constant: contentPadding),
            wordLabel.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor, constant: contentPadding),
            wordLabel.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor, constant: -contentPadding),
            
            
            translatedWordLabel.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor, constant: contentPadding),
            translatedWordLabel.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor, constant: -contentPadding),
            translatedWordLabel.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor, constant: -contentPadding),
            
            stackView.centerYAnchor.constraint(equalTo: mainContainerView.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor, constant: -10),

            
        ])
    }
}
