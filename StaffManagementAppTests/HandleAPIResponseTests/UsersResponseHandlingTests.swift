//
//  UsersResponseHandlingTests.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 5/8/2025.
//

import Testing
import SwiftData
@testable import StaffManagementApp

struct UsersResponseHandlingTests {
    let mockKeychainService = MockKeychainService()
    
    @Test func testReceiveValidUsers() async {
        let sut = StaffDirectoryViewModel(apiService: ValidUsersAPIService(), keychainService: mockKeychainService)
        
        await sut.getStaffs()
        
        var lastStaffInCurrentPage = sut.staffs.last!
        await sut.loadMoreIfNeeded(current: lastStaffInCurrentPage)
        
        lastStaffInCurrentPage = sut.staffs.last!
        await sut.loadMoreIfNeeded(current: lastStaffInCurrentPage)
        
        #expect(sut.nextPage == 3)
        #expect(sut.numberOfPages == 3)
        #expect(sut.staffs.count == 9)
        #expect(sut.state == .hasData)
    }
    
    @Test func testReceiveEmptyUsers() async {
        let sut = StaffDirectoryViewModel(apiService: EmptyUsersAPIService(), keychainService: mockKeychainService)
        
        await sut.getStaffs()
        
        #expect(sut.numberOfPages == 0)
        #expect(sut.staffs.isEmpty)
        #expect(sut.state == .empty)
    }
    
    @Test func testReceiveError() async {
        let sut = StaffDirectoryViewModel(apiService: ErrorUsersAPIService(), keychainService: mockKeychainService)
        
        await sut.getStaffs()
        
        #expect(sut.numberOfPages == 0)
        #expect(sut.staffs.isEmpty)
        #expect(sut.state == .empty)
    }
}

final class ValidUsersAPIService: UsersAPIServiceProtocol {
    let firstPageUsers = [
        User(id: 1, email: "1", firstName: "1", lastName: "1", avatar: "1"),
        User(id: 2, email: "2", firstName: "2", lastName: "2", avatar: "2"),
        User(id: 3, email: "3", firstName: "3", lastName: "3", avatar: "3")
    ]
    
    let secondPageUsers = [
        User(id: 4, email: "4", firstName: "4", lastName: "4", avatar: "4"),
        User(id: 5, email: "5", firstName: "5", lastName: "5", avatar: "5"),
        User(id: 6, email: "6", firstName: "6", lastName: "6", avatar: "6")
    ]
    
    let thirdPageUsers = [
        User(id: 7, email: "7", firstName: "7", lastName: "7", avatar: "7"),
        User(id: 8, email: "8", firstName: "8", lastName: "8", avatar: "8"),
        User(id: 9, email: "9", firstName: "9", lastName: "9", avatar: "9")
    ]
    
    func getUsers(on page: Int) async -> Result<StaffManagementApp.UsersResponseDto, StaffManagementApp.NetworkError> {
        
        let dto = switch page {
        case 1:
            UsersResponseDto(page: 1, perPage: 3, total: 9, totalPages: 3, users: firstPageUsers)
        case 2:
            UsersResponseDto(page: 2, perPage: 3, total: 9, totalPages: 3, users: secondPageUsers)
        case 3:
            UsersResponseDto(page: 3, perPage: 3, total: 9, totalPages: 3, users: thirdPageUsers)
        default:
            UsersResponseDto(page: 0, perPage: 0, total: 0, totalPages: 0, users: [])
        }
        
        return .success(dto)
    }
}


final class EmptyUsersAPIService: UsersAPIServiceProtocol {
    func getUsers(on page: Int) async -> Result<StaffManagementApp.UsersResponseDto, StaffManagementApp.NetworkError> {
        let dto = UsersResponseDto(page: 0, perPage: 0, total: 0, totalPages: 0, users: [])
        return .success(dto)
    }
}


final class ErrorUsersAPIService: UsersAPIServiceProtocol {
    func getUsers(on page: Int) async -> Result<StaffManagementApp.UsersResponseDto, StaffManagementApp.NetworkError> {
        return .failure(.connectionError)
    }
}
