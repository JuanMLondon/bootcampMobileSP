//
//  EmailValidator.swift
//  Reto_Final
//
//  Created by JML on 26/12/22.
//

import Foundation

struct EmailValidator {

    func validateEmailString(_ string: String) -> Bool {
        if string.count > 100 {
            return false
        }
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
}
