//
//  NameValidViewController.swift
//  testView
//
//  Created by Рамил Гаджиев on 01.03.2022.
//

import UIKit

class NameValidViewController: UIViewController {
    
    weak var delegate: ChangeNextVCProtocol?
    
    private var attempts: Int = 3 {
        didSet {
            if attempts == 0 {
                delegate?.onCloseName()
            }
        }
    }
    
    private lazy var nameValidView = Validview(
        with: .fullName,
        delegate: self
    )
    
    private lazy var onValidEmailButton = CustomButton(
        with: "К валидации Email",
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
        myView.backgroundColor = #colorLiteral(red: 0.8321695924, green: 0.985483706, blue: 0.4733308554, alpha: 1)
        self.view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initConstraints()
        initListeners()
    }
}

// -MARK: private methods
private extension NameValidViewController {
    func initConstraints() {
        view.addSubview(nameValidView)
        view.addSubview(onValidEmailButton)
        view.addSubview(descriptionLabel)
        nameValidView.translatesAutoresizingMaskIntoConstraints = false
        onValidEmailButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameValidView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            nameValidView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameValidView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            onValidEmailButton.topAnchor.constraint(equalTo: nameValidView.bottomAnchor, constant: 40),
            onValidEmailButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            onValidEmailButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            onValidEmailButton.heightAnchor.constraint(equalToConstant: 56),
            
            descriptionLabel.topAnchor.constraint(equalTo: onValidEmailButton.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func initListeners() {
        onValidEmailButton.buttonDidTapped = { [weak self] in
            self?.delegate?.onEmail()
        }
    }
}

// -MARK: ValidViewProtocol
extension NameValidViewController: ValidViewProtocol {
    func buttonDidTapped(with isValid: Bool) {
        if isValid == false {
            self.attempts -= 1
            descriptionLabel.text = "Количество оставшихся попыток: \(attempts)"
        }
    }
}

