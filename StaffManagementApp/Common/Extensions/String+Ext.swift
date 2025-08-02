//
//  String+Ext.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 2/8/2025.
//

extension String {
    var isAlphaNumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
}
