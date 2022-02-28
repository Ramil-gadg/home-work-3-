//
//  Validatable.swift
//  testView
//
//  Created by Рамил Гаджиев on 01.03.2022.
//

import UIKit

protocol Validatable {
    func validate(validType: ValidType, text: String) -> Bool
}

extension Validatable {
    func validate(validType: ValidType, text: String) -> Bool {
        switch validType {
        case .email:
            let regex = try! NSRegularExpression(
                pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
                options: .caseInsensitive
            )
            return regex.firstMatch(
                in: text,
                options: [],
                range: NSRange(location: 0,length: text.count)) != nil
        case .fullName:
            let regex = try! NSRegularExpression(
                pattern: "[A-Za-zА-ЯЁа-яё-]{2,}+\\s{1}+[A-Za-zА-ЯЁа-яё-]{2,}",
                options: .caseInsensitive
            )
            return regex.firstMatch(
                in: text,
                options: [],
                range: NSRange(location: 0, length: text.count)) != nil
        }
    }
}
