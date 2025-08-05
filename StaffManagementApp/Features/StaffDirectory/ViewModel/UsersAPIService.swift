//
//  UsersAPIService.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 5/8/2025.
//

final class UsersAPIService: UsersAPIServiceProtocol {
    func getUsers(on page: Int) async -> Result<UsersResponseDto, NetworkError> {
        do {
            let request = try UsersRequest(page: page).create()
            return await NetworkManager.shared.send(request, as: UsersResponseDto.self)
        } catch {
            return .failure(.invalidRequest)
        }
    }
}
