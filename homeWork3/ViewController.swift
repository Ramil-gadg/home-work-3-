//
//  ViewController.swift
//  testView
//
//  Created by Рамил Гаджиев on 22.02.2022.
//

import UIKit

protocol ChangeNextVCProtocol: AnyObject {
    func onName()
    func onEmail()
    func onCloseEmail()
    func onCloseName()
}

class RootViewController: UIViewController {
    
    private lazy var onNameValidButton = CustomButton(
        with: "Валидировать имя"
    )
    
    private lazy var onEmailValidButton = CustomButton(
        with: "Валидировать Email",
        color: .systemGreen
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Выбор валидации"
        view.backgroundColor = .systemBackground
        initConstraints()
        initListeners()
    }
}

// -MARK: private methods
private extension RootViewController {
    
    func initConstraints() {
        view.addSubview(onNameValidButton)
        view.addSubview(onEmailValidButton)
        onNameValidButton.translatesAutoresizingMaskIntoConstraints = false
        onEmailValidButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            onNameValidButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            onNameValidButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            onNameValidButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            onNameValidButton.heightAnchor.constraint(equalToConstant: 60),
            
            onEmailValidButton.topAnchor.constraint(equalTo: onNameValidButton.bottomAnchor, constant: 40),
            onEmailValidButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            onEmailValidButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            onEmailValidButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func initListeners() {
        
        onNameValidButton.buttonDidTapped = { [weak self] in
            let nameVC = NameValidViewController()
            nameVC.delegate = self
            self?.present(
                nameVC,
                animated: true
            )
        }
        
        onEmailValidButton.buttonDidTapped = { [weak self] in
            let emailVC = EmailValidViewController()
            emailVC.delegate = self
            self?.navigationController?.pushViewController(
                emailVC,
                animated: true
            )
        }
    }
}

//MARK: - ChangeNextVCProtocol
extension RootViewController: ChangeNextVCProtocol {
    
    func onCloseEmail() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func onCloseName() {
        self.navigationController?.dismiss(animated: true)
    }
    
    func onName() {
        self.navigationController?.popViewController(animated: true)
        let nameVC = NameValidViewController()
        nameVC.delegate = self
        self.present(
            nameVC,
            animated: true
        )
    }
    
    func onEmail() {
        self.navigationController?.dismiss(animated: true)
        let emailVC = EmailValidViewController()
        emailVC.delegate = self
        self.navigationController?.pushViewController(
            emailVC,
            animated: true
        )
    }
}
