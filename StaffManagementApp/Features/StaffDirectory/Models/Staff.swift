//
//  Staff.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 3/8/2025.
//

import SwiftData
import Foundation

@Model
final class Staff {
    var id: Int
    var email: String
    var firstName: String
    var lastName: String
    var avatar: String

    init(id: Int, email: String, firstName: String, lastName: String, avatar: String) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.avatar = avatar
    }
}

