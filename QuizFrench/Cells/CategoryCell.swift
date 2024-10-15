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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMainContainerView()
        configureFooterContainerView()
        configure()
        
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
        mainContainerView.layer.borderWidth = 3
        mainContainerView.layer.borderColor = UIColor.systemGray4.cgColor
        mainContainerView.clipsToBounds = true
    }
    
    func configureFooterContainerView() {
        footerContainerView.backgroundColor = .systemGray5
        footerContainerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configure() {
        addSubview(mainContainerView)
        footerContainerView.addSubview(categoryLabel)
        mainContainerView.addSubview(footerContainerView)
        mainContainerView.addSubview(categoryImage)
        
        
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
            
            categoryImage.centerYAnchor.constraint(equalTo: mainContainerView.centerYAnchor, constant: -20),
            categoryImage.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor, constant: padding),
            categoryImage.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor, constant: -padding),
            categoryImage.heightAnchor.constraint(equalToConstant: 70),
            categoryImage.widthAnchor.constraint(equalToConstant: 70),
            
            categoryLabel.topAnchor.constraint(equalTo: footerContainerView.topAnchor, constant: padding),
            categoryLabel.leadingAnchor.constraint(equalTo: footerContainerView.leadingAnchor, constant: padding),
            categoryLabel.trailingAnchor.constraint(equalTo: footerContainerView.trailingAnchor, constant: -padding),
            categoryLabel.bottomAnchor.constraint(equalTo: footerContainerView.bottomAnchor, constant: -padding),
        ])
    }
}

