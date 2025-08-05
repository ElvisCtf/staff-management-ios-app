//
//  TextFieldType.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 5/8/2025.
//

import UIKit

enum TextFieldType: String, Hashable {
    case email = "Email"
    case password = "Password"
    
    var placeholder: String {
        self.rawValue
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .email:
            .emailAddress
        case .password:
            .asciiCapable
        }
    }
    
    var errorMessage: String {
        switch self {
            case .email:
            return "Invalid email format."
        case .password:
            return "Password should be letter and number only,\nand 6 to 10 characters long."
        }
    }
    
    var validator: (String) -> Bool {
        switch self {
        case .email:
            { $0.isEmail }
        case .password:
            { $0.isPassword }
        }
    }
}
