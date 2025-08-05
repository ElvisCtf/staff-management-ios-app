//
//  LoginAPIServiceProtocol.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 5/8/2025.
//

protocol LoginAPIServiceProtocol {
    func postLogin(with dto: LoginRequestDto) async -> Result<LoginResponseDto, NetworkError>
}
