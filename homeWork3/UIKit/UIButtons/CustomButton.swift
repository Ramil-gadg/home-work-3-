//
//  CustomButton.swift
//  testView
//
//  Created by Рамил Гаджиев on 01.03.2022.
//

import UIKit

class CustomButton: UIButton {
    
    var buttonDidTapped: (() -> Void)?
    
    init(with text: String,
         color: UIColor? = .blue,
         titleColor: UIColor? = .white
    ) {
        super.init(frame: .zero)
        self.setTitle(text, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = color
        self.layer.cornerRadius = 12
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 6)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.3
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        initComponent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initComponent() {
        addTarget(
            self,
            action: #selector(didTappedButton),
            for: .touchUpInside
        )
    }
    
    @objc
    func didTappedButton() {
        buttonDidTapped?()
    }
}
