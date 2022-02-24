//
//  Validview.swift
//  testView
//
//  Created by Рамил Гаджиев on 24.02.2022.
//

import UIKit

protocol ValidViewProtocol: AnyObject {
    func buttonDidTapped(with text: String)
}

enum ValidType {
    case email
    case fullName
    
    var placeHolder: String {
        switch self {
        case .fullName:
            return "введите имя..."
        case .email:
            return "введите email..."
        }
    }
    
    var labelText: String {
        switch self {
        case .fullName:
            return "Имя и фамилия"
        case .email:
            return "Эл. почта"
        }
    }
    
    var textAboutLastValidate: String {
        switch self {
        case .fullName:
            return "В последний раз были провалидированы имя и фамилия"
        case .email:
            return "В последний раз был провалидирован Email"
        }
    }
    
    var incorrectData: String {
        return "Не правильные данные"
    }
}

class Validview: UIView {
    
    private (set) var validType: ValidType
    weak var delegate: ValidViewProtocol?
    
    private lazy var validTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .systemBackground
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private lazy var validButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.setTitle("Валидировать", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Не дави на меня", for: .highlighted)
        button.layer.cornerRadius = 12
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 2, height: 6)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.3
        button.addTarget(self,
                         action: #selector(didTappedValidButton),
                         for: .touchUpInside
        )
        return button
    }()
    
    private lazy var validLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    
    init(with type: ValidType, delegate: ValidViewProtocol) {
        self.validType = type
        self.delegate = delegate
        super.init(frame: .zero)
        configure()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
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
    
    @objc
    func didTappedValidButton() {
        guard let text = validTextField.text else { return }
        switch validType {
        case .fullName:
            validLabel.text = text.isValidFullName() ? text : validType.incorrectData
            validLabel.textColor = text.isValidFullName() ? .systemGreen : .systemRed
            delegate?.buttonDidTapped(with: validType.textAboutLastValidate)
        case .email:
            validLabel.text = text.isValidEmail() ? text : validType.incorrectData
            validLabel.textColor = text.isValidEmail() ? .systemGreen : .systemRed
            delegate?.buttonDidTapped(with: validType.textAboutLastValidate)
        }
    }
}
