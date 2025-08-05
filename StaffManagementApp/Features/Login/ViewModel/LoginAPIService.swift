//
//  LoginAPIService.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 5/8/2025.
//

final class LoginAPIService: LoginAPIServiceProtocol {
    func postLogin(with dto: LoginRequestDto) async -> Result<LoginResponseDto, NetworkError> {
        do {
            let request = try LoginRequest(dto: dto).create()
            return await NetworkManager.shared.send(request, as: LoginResponseDto.self)
        } catch {
            return .failure(.invalidRequest)
        }
    }
}
