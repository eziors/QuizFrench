//
//  QFProgressBarView.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 24/10/24.
//

import UIKit

class QFProgressBarView: UIProgressView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        progress = 0
        
        progressViewStyle = .default
        tintColor = UIColor.systemBlue
    }
}
