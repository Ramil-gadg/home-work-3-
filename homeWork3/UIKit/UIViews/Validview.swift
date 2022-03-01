//
//  Validview.swift
//  testView
//
//  Created by Рамил Гаджиев on 24.02.2022.
//

import UIKit

protocol ValidViewProtocol: AnyObject {
    func buttonDidTapped(with isValid: Bool)
}

class Validview: UIView, Validatable {
    
    private (set) var validType: ValidType
    weak var delegate: ValidViewProtocol?
    
    private lazy var validTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .systemBackground
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private lazy var validButton = CustomButton(
        with: "Валидировать"
    )
    
    private lazy var validLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    init(
        with type: ValidType,
        delegate: ValidViewProtocol
    ) {
        self.validType = type
        self.delegate = delegate
        super.init(frame: .zero)
        configure()
        initConstraints()
        initListeners()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 12
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 5, height: 6)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.5
        self.validTextField.placeholder = validType.placeHolder
        self.validLabel.text = validType.labelText
    }
    
    private func initConstraints() {
        self.addSubview(validTextField)
        self.addSubview(validButton)
        self.addSubview(validLabel)
        self.translatesAutoresizingMaskIntoConstraints = false
        validButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            validTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            validTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            validTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            validButton.topAnchor.constraint(equalTo: validTextField.bottomAnchor, constant: 20),
            validButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            validButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            validButton.heightAnchor.constraint(equalToConstant: 44),
            
            validLabel.topAnchor.constraint(equalTo: validButton.bottomAnchor, constant: 20),
            validLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            validLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            validLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
    
    func initListeners() {
        validButton.buttonDidTapped = { [weak self] in
            guard let self = self else {
                return
            }
            guard let text = self.validTextField.text else { return }
            let isValid = self.validate(validType: self.validType, text: text)
            self.validLabel.text = isValid ? text : self.validType.incorrectData
            self.validLabel.textColor = isValid ? .systemGreen : .systemRed
            self.delegate?.buttonDidTapped(with: isValid)
        }
    }
}
