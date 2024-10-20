//
//  UIView+Ext.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 28/09/24.
//

import UIKit

extension UIView {
    func startBorderAnimation() {
        // Criação da animação de pulsação da borda
        let borderAnimation = CABasicAnimation(keyPath: "borderColor")
        borderAnimation.fromValue = UIColor.systemGray4.cgColor
        borderAnimation.toValue = UIColor.systemBlue.cgColor
        borderAnimation.duration = 0.6
        borderAnimation.autoreverses = true
        borderAnimation.repeatCount = .infinity
        
        // Aplicar a animação na camada do mainContainerView
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.systemBlue.cgColor
        self.layer.add(borderAnimation, forKey: "borderPulse")
    }

    func stopBorderAnimation() {
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: { self.layer.borderColor = UIColor.systemGray4.cgColor })
        self.layer.removeAnimation(forKey: "borderPulse")
    }
}
