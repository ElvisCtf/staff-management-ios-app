//
//  StaffDirectoryViewModel.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 3/8/2025.
//

import SwiftUI

@Observable final class StaffDirectoryViewModel {
    var staffs: [User] = []
    
    @ObservationIgnored var token = ""
    @ObservationIgnored var currentPage = 1
    @ObservationIgnored private let apiService: APIServiceProtocol
    @ObservationIgnored private let keychainService: KeychainServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService(), keychainService: KeychainServiceProtocol = KeychainService()) {
        self.apiService = apiService
        self.keychainService = keychainService
        
        token = keychainService.readToken() ?? ""
    }
    
    func getUsers() async {
        let result = await apiService.getUsers(on: currentPage)
        switch result {
        case .success(let dto):
            handleSuccess(with: dto.users)
        case .failure(_):
            ()
        }
    }
    
    private func handleSuccess(with users: [User]) {
        staffs += users
    }
}
