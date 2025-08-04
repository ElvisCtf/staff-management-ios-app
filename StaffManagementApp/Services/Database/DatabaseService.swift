//
//  DatabaseSer.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 3/8/2025.
//

import SwiftData

protocol DatabaseServiceProtocol {
    var context: ModelContext { get }
    
    func cacheStaffs(_ users: [User])
    func getUsers() -> [User]
    func getStaffs() -> [Staff]
    func clearStaffs()
}

final class DatabaseService: DatabaseServiceProtocol {
    var context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func cacheStaffs(_ users: [User]) {
        for user in users {
            let contact = Staff(id: user.id, email: user.email, firstName: user.firstName, lastName: user.lastName, avatar: user.avatar)
            context.insert(contact)
        }
        try? context.save()
    }
    
    func getUsers() -> [User] {
        let staffs = getStaffs()
        return staffs.map {
            User(id: $0.id, email: $0.email, firstName: $0.firstName, lastName: $0.lastName, avatar: $0.avatar)
        }
    }

    func getStaffs() -> [Staff] {
        let descriptor = FetchDescriptor<Staff>()
        return (try? context.fetch(descriptor)) ?? []
    }

    func clearStaffs() {
        let staffs = getStaffs()
        for staff in staffs {
            context.delete(staff)
        }
        try? context.save()
    }
}
