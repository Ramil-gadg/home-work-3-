//
//  String+Extension.swift
//  testView
//
//  Created by Рамил Гаджиев on 23.02.2022.
//

import UIKit

extension String {
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(
            pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
            options: .caseInsensitive
        )
        return regex.firstMatch(in: self,
                                options: [],
                                range: NSRange(location: 0,length: count)) != nil
    }
    
    func isValidFullName() -> Bool {
        let regex = try! NSRegularExpression(
            pattern: "[A-Za-zА-ЯЁа-яё-]{2,}+\\s{1}+[A-Za-zА-ЯЁа-яё-]{2,}",
            options: .caseInsensitive
        )
        return regex.firstMatch(in: self,
                                options: [],
                                range: NSRange(location: 0, length: count)) != nil
    }
}
