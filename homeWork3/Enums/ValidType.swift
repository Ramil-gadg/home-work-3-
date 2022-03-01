//
//  ValidType.swift
//  testView
//
//  Created by Рамил Гаджиев on 02.03.2022.
//

import UIKit

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
