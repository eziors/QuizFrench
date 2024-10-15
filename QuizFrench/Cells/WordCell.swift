import UIKit
import AVFoundation


class WordCell: UITableViewCell {
    
    static let reuseID = "WordCell"
    let mainContainerView = UIView()
    let wordLabel = QFTitleLabel(textAlignment: .left, fontSize: 22)
    let translatedWordLabel = QFSecondaryTitleLabel(fontSize: 18)
    
    let stackView = UIStackView()
    
    var player = AVAudioPlayer()
    let playButton = QFPlayButton()
    let copyButton = QFCopyButton()
    let favoriteButton = QFFavoriteButton()
    
    var wordTrack: String?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUIElements()
        configureMainContainerView()
        configureStackView()
        configureButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(wordString: Item.Question) {
        wordLabel.text = wordString.correctAnswer
        translatedWordLabel.text = wordString.translation.english
        wordTrack = "word_\(wordString.correctAnswer)_f"

    }
    
    private func configureButtons() {
        playButton.addTarget(self, action: #selector(playButtonAction), for: .touchUpInside)
        copyButton.addTarget(self, action: #selector(copyButtonAction), for: .touchUpInside)
    }
    
    @objc func playButtonAction() {
        
        
        guard let audioTrack = wordTrack else { return }
        
        guard let url = Bundle.main.url(forResource: audioTrack, withExtension: "mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)

            mainContainerView.startBorderAnimation()
            player.play()
            player.delegate = self
        } catch {
            print("Error trying to reproduce audio: \(error.localizedDescription)")
        }
    }
    
    @objc func copyButtonAction() {
        UIPasteboard.general.string = wordLabel.text
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
            wordLabel.widthAnchor.constraint(equalToConstant: 220),
            
            
            translatedWordLabel.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor, constant: contentPadding),
            translatedWordLabel.widthAnchor.constraint(equalToConstant: 220),
            translatedWordLabel.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor, constant: -contentPadding),
            
            
            stackView.centerYAnchor.constraint(equalTo: mainContainerView.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor, constant: -10),
            
            
        ])
    }
}

extension WordCell: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        mainContainerView.stopBorderAnimation()
    }
}
