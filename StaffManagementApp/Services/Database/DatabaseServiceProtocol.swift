//
//  DatabaseServiceProtocol.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 6/8/2025.
//

import SwiftData

protocol DatabaseServiceProtocol {
    var context: ModelContext { get }
    
    func cacheStaffs(_ staffs: [Staff])
    func getStaffs() -> [Staff]
    func clearStaffs()
}
