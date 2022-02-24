//
//  ViewController.swift
//  testView
//
//  Created by Рамил Гаджиев on 22.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var nameValidView = Validview(with: .fullName, delegate: self)
    
    private lazy var emailValidView = Validview(with: .email, delegate: self)
    
    private lazy var descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        lbl.textColor = .systemGray
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Экран валидации"
        view.backgroundColor = .systemBackground
        initConstraints()
    }
    
    private func initConstraints() {
        view.addSubview(nameValidView)
        view.addSubview(emailValidView)
        view.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            nameValidView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            nameValidView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameValidView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            emailValidView.topAnchor.constraint(equalTo: nameValidView.bottomAnchor, constant: 40),
            emailValidView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailValidView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: emailValidView.bottomAnchor, constant: 40),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}

//MARK: - ValidViewProtocol
extension ViewController: ValidViewProtocol {
    func buttonDidTapped(with text: String) {
        descriptionLabel.text = text
    }
}
