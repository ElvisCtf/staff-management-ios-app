//
//  String+Ext.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 2/8/2025.
//

import Foundation

extension String {
    var isAlphaNumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    var isEmail: Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    var isPassword: Bool {
        let isLength6To10 = self.count >= 6 && self.count <= 10
        let isAlphaNumeric = self.isAlphaNumeric
        return isLength6To10 && isAlphaNumeric
    }
}
