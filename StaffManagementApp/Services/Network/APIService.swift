//
//  APIService.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 2/8/2025.
//

protocol APIServiceProtocol {
    func postLogin(with dto: LoginRequestDto) async -> Result<LoginResponseDto, NetworkError>
}

final class APIService: APIServiceProtocol {
    func postLogin(with dto: LoginRequestDto) async -> Result<LoginResponseDto, NetworkError> {
        do {
            let request = try LoginRequest(dto: dto).create()
            return await NetworkManager.shared.send(request, as: LoginResponseDto.self)
        } catch {
            return .failure(.invalidRequest)
        }
    }
}
