//
//  CachingTests.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 6/8/2025.
//

import Testing
import SwiftData
@testable import StaffManagementApp

struct CachingTests {
    @MainActor @Test func testIsOfflineMode() throws {
        let sut = StaffDirectoryViewModel(apiService: ValidUsersAPIService(), keychainService: MockKeychainService())
        sut.setDatabaseService(MockDatabaseService(context: try createContext()))
        
        #expect(sut.staffs.isEmpty == false)
        #expect(sut.state == .hasData)
        #expect(sut.isOfflineMode == true)
    }
    
    @MainActor private func createContext() throws -> ModelContext {
        let schema = Schema([Staff.self])
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let modelContainer = try ModelContainer(for: schema, configurations: [config])
        return modelContainer.mainContext
    }
}

final class MockDatabaseService: DatabaseServiceProtocol {
    var context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func cacheStaffs(_ staffs: [StaffManagementApp.Staff]) {
        
    }
    
    func getStaffs() -> [StaffManagementApp.Staff] {
        let staffs = [
            Staff(id: 1, email: "1", firstName: "1", lastName: "1", avatar: "1"),
            Staff(id: 2, email: "2", firstName: "2", lastName: "2", avatar: "2"),
            Staff(id: 3, email: "3", firstName: "3", lastName: "3", avatar: "3")
        ]
        
        return staffs
    }
    
    func clearStaffs() {
        
    }
}
