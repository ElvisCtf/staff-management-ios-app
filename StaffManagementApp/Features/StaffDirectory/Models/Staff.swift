//
//  Staff.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 3/8/2025.
//

import SwiftData
import Foundation

@Model
final class Staff: Identifiable, Equatable {
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
    
    static func == (lhs: Staff, rhs: Staff) -> Bool {
        return lhs.id == rhs.id &&
        lhs.email == rhs.email &&
        lhs.firstName == rhs.firstName &&
        lhs.lastName == rhs.lastName &&
        lhs.avatar == rhs.avatar
    }
    
}

