//
//  LoginViewModel.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 2/8/2025.
//

import SwiftUI

enum TextFieldFocus: Hashable {
    case email
    case password
}

@Observable final class LoginViewModel {
    var emailInput = ""
    var passwordInput = ""
    var isEmailValid = true
    var isPasswordValid = true
    
    var isInputValid: Bool { isEmailValid && isPasswordValid }
    
    func validateEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }

}


