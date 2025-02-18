//
//  ItemInfoVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 13/09/24.
//

import UIKit

class QFItemInfoVC: UIViewController {
    
    let itemInfoView = QFItemInfoView()

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        createPushVCTapGesture()
    }
        
    
    func set(backgroundColor: UIColor) {
        view.layer.cornerRadius = 18
        view.backgroundColor = backgroundColor
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
    }
    
    weak var delegate: QFHomeVCDelegate!
    
    func createPushVCTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(actionButtonTapped))
        view.addGestureRecognizer(tap)
    }
    
    @objc func actionButtonTapped() { }
    
    
    private func layoutUI() {
        view.addSubview(itemInfoView)
        
        itemInfoView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 15
        
        NSLayoutConstraint.activate([
            itemInfoView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            itemInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemInfoView.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
