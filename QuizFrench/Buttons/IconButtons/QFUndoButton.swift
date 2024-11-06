//
//  QFUndoButton.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 02/11/24.
//

import UIKit

class QFUndoButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        
        let buttonSizeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .default)
        let copyButtonIcon = UIImage(systemName: "delete.backward", withConfiguration: buttonSizeConfig)
        translatesAutoresizingMaskIntoConstraints = false
        
        self.contentMode = .scaleToFill
        self.setImage(copyButtonIcon, for: .normal)
    }
}
