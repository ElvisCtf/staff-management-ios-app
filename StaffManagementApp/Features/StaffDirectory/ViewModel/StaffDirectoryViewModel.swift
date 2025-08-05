//
//  StaffDirectoryViewModel.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 3/8/2025.
//

import SwiftUI

enum DataState {
    case empty
    case hasData
}

@Observable final class StaffDirectoryViewModel {
    var staffs: [Staff] = []
    var state: DataState = .empty
    var isLoadingMore = false
    var token = ""
    
    @ObservationIgnored var nextPage = 1
    @ObservationIgnored var numberOfPages = 0
    
    @ObservationIgnored private let apiService: UsersAPIServiceProtocol
    @ObservationIgnored private let keychainService: KeychainServiceProtocol
    @ObservationIgnored private var databaseService: DatabaseServiceProtocol? = nil
    @ObservationIgnored private var isOfflineMode = false
    
    init(apiService: UsersAPIServiceProtocol, keychainService: KeychainServiceProtocol) {
        self.apiService = apiService
        self.keychainService = keychainService
    }
    
    func setDatabaseService(_ dbService: DatabaseServiceProtocol?) {
        databaseService = dbService
        if let cachedStaff = dbService?.getStaffs(), !cachedStaff.isEmpty {
            staffs = cachedStaff
            state = .hasData
            isOfflineMode = true
        }
    }
    
    func showToken() {
        token = keychainService.readToken() ?? ""
    }
    
    func logout() {
        keychainService.deleteToken()
        databaseService?.clearStaffs()
    }
    
    func loadMoreIfNeeded(current: Staff) async {
        guard !isOfflineMode else { return }
        
        if shouldLoadMore(current) {
            nextPage += 1
            isLoadingMore = true
            await getStaffs()
            isLoadingMore = false
        }
    }
    
    func getStaffs() async {
        guard !isOfflineMode else { return }
        
        let result = await apiService.getUsers(on: nextPage)
        switch result {
        case .success(let dto):
            handleSuccess(with: dto)
        case .failure(_):
            ()
        }
    }
    
    private func handleSuccess(with dto: UsersResponseDto) {
        numberOfPages = dto.totalPages
        let fetchedStaffs = dto.users.map { Staff(id: $0.id, email: $0.email, firstName: $0.firstName, lastName: $0.lastName, avatar: $0.avatar) }
        staffs += fetchedStaffs
        databaseService?.cacheStaffs(fetchedStaffs)
        
        if state == .empty && !staffs.isEmpty {
            state = .hasData
        }
    }
    
    private func shouldLoadMore(_ current: Staff) -> Bool {
        let isStillHavePages = nextPage < numberOfPages
        return current == staffs.last && isStillHavePages && !isLoadingMore
    }
}
