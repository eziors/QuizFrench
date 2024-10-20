//
//  QFWordCategoryCell.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 28/09/24.
//

import UIKit


class CategoryCell: UICollectionViewCell {
    
    static let reuseID = "WordCategoryCell"
    let mainContainerView = UIView()
    let footerContainerView = UIView()
    
    let categoryImage = QFCategoryImageView(frame: .zero)
    let categoryLabel = QFTitleLabel(textAlignment: .center, fontSize: 20)
    
    let stackView = UIStackView()
    var starsImageViews = [UIImageView]()
    var completedCount = 1
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMainContainerView()
        configureFooterContainerView()
        configure()
        configureStarView()
        configureStackView()
        changeStarColor(count: completedCount)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(category: Category) {
        categoryLabel.text = category.name
        categoryImage.setImage(imageURL: category.image)
        
    }
    
    func configureMainContainerView() {
        mainContainerView.backgroundColor = .systemBackground
        mainContainerView.translatesAutoresizingMaskIntoConstraints = false
        mainContainerView.layer.cornerRadius = 12
        mainContainerView.layer.borderWidth = 4
        mainContainerView.layer.borderColor = completedCount >= 3 ? UIColor.systemYellow.cgColor : UIColor.systemGray4.cgColor
        mainContainerView.clipsToBounds = true
    }
    
    func configureFooterContainerView() {
        footerContainerView.backgroundColor = .systemBackground
        footerContainerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureStarView() {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .default)
        
        for _ in 1...3 {
            let starView = UIImageView()
            starView.image = UIImage(systemName: "star.fill", withConfiguration: imageConfig)
            starView.tintColor = .gray
            starsImageViews.append(starView)
        }
    }
    
    func configureStackView() {
        for star in starsImageViews {
            stackView.addArrangedSubview(star)
        }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
    }
    
    func changeStarColor(count: Int) {
        for i in 0..<count {
            self.starsImageViews[i].tintColor = .systemYellow
        }
    }
    
    private func configure() {
        addSubview(mainContainerView)
        footerContainerView.addSubview(categoryLabel)
        mainContainerView.addSubview(footerContainerView)
        mainContainerView.addSubview(categoryImage)
        addSubview(stackView)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            mainContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            mainContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            mainContainerView.heightAnchor.constraint(equalToConstant: 200),
            mainContainerView.widthAnchor.constraint(equalToConstant: 80),
            
            footerContainerView.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor),
            footerContainerView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            footerContainerView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            footerContainerView.heightAnchor.constraint(equalToConstant: 60),
            
            
            categoryImage.topAnchor.constraint(equalTo: mainContainerView.topAnchor),
            categoryImage.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            categoryImage.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            categoryImage.bottomAnchor.constraint(equalTo: footerContainerView.topAnchor),
            
            
            categoryLabel.topAnchor.constraint(equalTo: footerContainerView.topAnchor, constant: padding),
            categoryLabel.leadingAnchor.constraint(equalTo: footerContainerView.leadingAnchor, constant: padding),
            categoryLabel.trailingAnchor.constraint(equalTo: footerContainerView.trailingAnchor, constant: -padding),
            categoryLabel.bottomAnchor.constraint(equalTo: footerContainerView.bottomAnchor, constant: -padding),
            
            
            stackView.topAnchor.constraint(equalTo: footerContainerView.bottomAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: footerContainerView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: footerContainerView.trailingAnchor, constant: -20),
        ])
    }
}
