//
//  StaffDirectoryViewModel.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 3/8/2025.
//

import SwiftUI

@Observable final class StaffDirectoryViewModel {
    var staffs: [User] = []
    var isLoadingMore = false
    
    @ObservationIgnored var token = ""
    
    @ObservationIgnored var nextPage = 1
    @ObservationIgnored var numberOfPages = 0
    
    @ObservationIgnored private let apiService: APIServiceProtocol
    @ObservationIgnored private let keychainService: KeychainServiceProtocol
    
    init(apiService: APIServiceProtocol, keychainService: KeychainServiceProtocol) {
        self.apiService = apiService
        self.keychainService = keychainService
        
        token = keychainService.readToken() ?? ""
    }
    
    func loadMoreIfNeeded(current: User) async {
        if shouldLoadMore(current) {
            nextPage += 1
            isLoadingMore = true
            await getUsers()
            isLoadingMore = false
        }
    }
    
    func getUsers() async {
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
        staffs += dto.users
    }
    
    private func shouldLoadMore(_ current: User) -> Bool {
        let isStillHavePages = nextPage < numberOfPages
        return current == staffs.last && isStillHavePages && !isLoadingMore
    }
}
