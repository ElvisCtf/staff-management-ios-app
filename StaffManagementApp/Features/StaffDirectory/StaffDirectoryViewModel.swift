//
//  StaffDirectoryViewModel.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 3/8/2025.
//

import SwiftUI

@Observable final class StaffDirectoryViewModel {
    @ObservationIgnored var token = ""
    @ObservationIgnored private let apiService: APIServiceProtocol
    @ObservationIgnored private let keychainService: KeychainServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService(), keychainService: KeychainServiceProtocol = KeychainService()) {
        self.apiService = apiService
        self.keychainService = keychainService
        
        token = keychainService.readToken() ?? ""
    }
}
