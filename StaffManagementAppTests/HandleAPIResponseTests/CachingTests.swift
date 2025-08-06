//
//  CachingTests.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 6/8/2025.
//

import Testing
import SwiftData
import Foundation
@testable import StaffManagementApp

struct CachingTests {
    @Test func testIsOfflineMode() throws {
        let sut = StaffDirectoryViewModel(apiService: ValidUsersAPIService(), keychainService: MockKeychainService())
        sut.setDatabaseService(CachedDatabaseService(context: try createMockContext()))
        
        #expect(sut.staffs.isEmpty == false)
        #expect(sut.state == .hasData)
        #expect(sut.isOfflineMode == true)
    }
    
    @Test func testCachingData() async throws {
        let sut = StaffDirectoryViewModel(apiService: ValidUsersAPIService(), keychainService: MockKeychainService())
        sut.setDatabaseService(NonCachedDatabaseService(context: try createMockContext()))
        
        // Fetch page 1 data from mock APIService
        await sut.getStaffs()
        
        // Fetch page 2 data from mock APIService
        var lastStaffInCurrentPage = sut.staffs.last!
        await sut.loadMoreIfNeeded(current: lastStaffInCurrentPage)
        
        // Fetch page 3 data from mock APIService
        lastStaffInCurrentPage = sut.staffs.last!
        await sut.loadMoreIfNeeded(current: lastStaffInCurrentPage)
        
        let cachedStaffs = sut.databaseService?.getStaffs() ?? []
        #expect(cachedStaffs.count == sut.staffs.count)
    }
    
    @Test func testClearCachingData() async throws {
        let sut = StaffDirectoryViewModel(apiService: ValidUsersAPIService(), keychainService: MockKeychainService())
        sut.setDatabaseService(NonCachedDatabaseService(context: try createMockContext()))
        
        // Fetch page 1 data from mock APIService
        await sut.getStaffs()
        
        // Fetch page 2 data from mock APIService
        var lastStaffInCurrentPage = sut.staffs.last!
        await sut.loadMoreIfNeeded(current: lastStaffInCurrentPage)
        
        // Fetch page 3 data from mock APIService
        lastStaffInCurrentPage = sut.staffs.last!
        await sut.loadMoreIfNeeded(current: lastStaffInCurrentPage)
        
        // Clear cache
        sut.databaseService?.clearStaffs()
        
        let cachedStaffs = sut.databaseService?.getStaffs() ?? []
        #expect(cachedStaffs.isEmpty == true)
    }
    
    private func createMockContext() throws -> ModelContext {
        let schema = Schema([Staff.self])
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let modelContainer = try ModelContainer(for: schema, configurations: [config])
        return ModelContext(modelContainer)
        
    }
}


final class NonCachedDatabaseService: DatabaseServiceProtocol {
    var context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func cacheStaffs(_ staffs: [StaffManagementApp.Staff]) {
        for staff in staffs {
            context.insert(staff)
        }
        try? context.save()
    }
    
    func getStaffs() -> [StaffManagementApp.Staff] {
        let descriptor = FetchDescriptor<Staff>(sortBy: [SortDescriptor(\.id, order: .forward)])
        return (try? context.fetch(descriptor)) ?? []
    }
    
    func clearStaffs() {
        try? context.delete(model: Staff.self)
    }
}


final class CachedDatabaseService: DatabaseServiceProtocol {
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
