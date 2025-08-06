//
//  DatabaseSer.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 3/8/2025.
//

import SwiftData
import Foundation

final class DatabaseService: DatabaseServiceProtocol {
    var context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func cacheStaffs(_ staffs: [Staff]) {
        for staff in staffs {
            context.insert(staff)
        }
        try? context.save()
    }

    func getStaffs() -> [Staff] {
        let descriptor = FetchDescriptor<Staff>(sortBy: [SortDescriptor(\.id, order: .forward)])
        return (try? context.fetch(descriptor)) ?? []
    }

    func clearStaffs() {
        try? context.delete(model: Staff.self)
    }
}
