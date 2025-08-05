//
//  UsersAPIServiceProtocol.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 5/8/2025.
//

protocol UsersAPIServiceProtocol {
    func getUsers(on page: Int) async -> Result<UsersResponseDto, NetworkError>
}
