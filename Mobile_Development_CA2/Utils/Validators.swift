//
//  Validators.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 12/04/2025.
//

import Foundation

struct Validators {
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }

    static func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6
    }
}
