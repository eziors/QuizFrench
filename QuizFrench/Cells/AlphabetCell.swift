//
//  AlphabetCell.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 20/09/24.
//

import UIKit
import AVFoundation

class AlphabetCell: UICollectionViewCell {
    
    static let reuseID = "AlphabetCell"
    let mainContainerView = UIView()
    let footerContainerView = UIView()
    let alphabetLabel = QFTitleLabel(textAlignment: .center, fontSize: 40)
    
    let stackView = UIStackView()
    let playButton = UIButton()
    let copyButton = UIButton()
    
    
    var player = AVAudioPlayer()
    var playedAudio: Bool = false
    var alphabetTrack: String?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMainContainerView()
        configureFooterContainerView()
        configureButtons()
        configureStackView()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(alphabet: Alphabet) {
        alphabetLabel.text = alphabet.letter
        alphabetTrack = alphabet.audio
        
        
    }
    
    func configureMainContainerView() {
        mainContainerView.backgroundColor = .systemBackground
        mainContainerView.translatesAutoresizingMaskIntoConstraints = false
        mainContainerView.layer.cornerRadius = 12
        mainContainerView.layer.borderWidth = 3
        mainContainerView.layer.borderColor = playedAudio ? UIColor.systemBlue.cgColor : UIColor.systemGray4.cgColor
        mainContainerView.clipsToBounds = true
    }
    
    func configureFooterContainerView() {
        footerContainerView.backgroundColor = .systemGray5
        footerContainerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureButtons() {
        
        let buttonSizeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .light, scale: .default)
        let playButtonIcon = UIImage(systemName: "play.circle", withConfiguration: buttonSizeConfig)
        let copyButtonIcon = UIImage(systemName: "square.on.square", withConfiguration: buttonSizeConfig)
        
        
        
        playButton.contentMode = .scaleToFill
        playButton.setImage(playButtonIcon, for: .normal)
        playButton.addTarget(self, action: #selector(playButtonAction), for: .touchUpInside)
    
        copyButton.contentMode = .scaleToFill
        copyButton.setImage(copyButtonIcon, for: .normal)
        copyButton.addTarget(self, action: #selector(copyButtonAction), for: .touchUpInside)
        
    }
    
    @objc func playButtonAction() {
        
        guard let audioTrack = alphabetTrack else { return }
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
        print("Button tapped")
        UIPasteboard.general.string = alphabetLabel.text
    }

    
    func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(playButton)
        stackView.addArrangedSubview(copyButton)
    }
    
    private func configure() {
        addSubview(mainContainerView)
        mainContainerView.addSubview(alphabetLabel)
        mainContainerView.addSubview(footerContainerView)
        
        footerContainerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            mainContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            mainContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            mainContainerView.heightAnchor.constraint(equalToConstant: 180),
            mainContainerView.widthAnchor.constraint(equalToConstant: 100),
            
            footerContainerView.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor),
            footerContainerView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            footerContainerView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            footerContainerView.heightAnchor.constraint(equalToConstant: 60),
            
            alphabetLabel.centerXAnchor.constraint(equalTo: mainContainerView.centerXAnchor),
            alphabetLabel.centerYAnchor.constraint(equalTo: mainContainerView.centerYAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: footerContainerView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: footerContainerView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: footerContainerView.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: footerContainerView.bottomAnchor, constant: -8),
        ])
    }
}

extension AlphabetCell: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        mainContainerView.stopBorderAnimation() // Parar a animação de borda
    }
}
