//
//  EmailValidViewController.swift
//  testView
//
//  Created by Рамил Гаджиев on 01.03.2022.
//

import UIKit

class EmailValidViewController: UIViewController {
    
    weak var delegate: ChangeNextVCProtocol?
    
    private var attempts: Int = 3 {
        didSet {
            if attempts == 0 {
                delegate?.onCloseEmail()
            }
        }
    }
    
    private lazy var emailValidView = Validview(
        with: .email,
        delegate: self
    )
    
    private lazy var onValidNameButton = CustomButton(
        with: "К валидации имени",
        color: .systemGreen
    )
    
    private lazy var descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        lbl.textColor = .systemGray
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override func loadView() {
        let myView = UIView()
        myView.backgroundColor = #colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1)
        self.view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Валидация Email"
        initConstraints()
        initListeners()
    }
}

// -MARK: private methods
private extension EmailValidViewController {
    func initConstraints() {
        view.addSubview(emailValidView)
        view.addSubview(onValidNameButton)
        view.addSubview(descriptionLabel)
        emailValidView.translatesAutoresizingMaskIntoConstraints = false
        onValidNameButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailValidView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            emailValidView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailValidView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            onValidNameButton.topAnchor.constraint(equalTo: emailValidView.bottomAnchor, constant: 40),
            onValidNameButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            onValidNameButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            onValidNameButton.heightAnchor.constraint(equalToConstant: 56),
            
            descriptionLabel.topAnchor.constraint(equalTo: onValidNameButton.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func initListeners() {
        onValidNameButton.buttonDidTapped = { [weak self] in
            self?.delegate?.onName()
        }
    }
}

// -MARK: ValidViewProtocol
extension EmailValidViewController: ValidViewProtocol {
    func buttonDidTapped(with isValid: Bool) {
        if isValid == false {
            self.attempts -= 1
            descriptionLabel.text = "Количество оставшихся попыток: \(attempts)"
        }
    }
}
