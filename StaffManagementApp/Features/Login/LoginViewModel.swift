//
//  LoginViewModel.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 2/8/2025.
//

import SwiftUI

enum TextFieldFocus: Hashable {
    case email
    case password
}

@Observable final class LoginViewModel {
    var emailInput = ""
    var passwordInput = ""
    var isLoading = false
    var isShowAlert = false
    var isLoginSuccess = false
    
    @ObservationIgnored private let apiService: APIServiceProtocol
    @ObservationIgnored private let keychainService: KeychainServiceProtocol
    
    init(apiService: APIServiceProtocol, keychainService: KeychainServiceProtocol) {
        self.apiService = apiService
        self.keychainService = keychainService
    }
    
    func checkTokenExist() -> Bool {
        if let token = keychainService.readToken() {
            return !token.isEmpty
        }
        return false
    }
    
    func isInputValid() -> Bool {
        return emailInput.isEmail && passwordInput.isPassword
    }
    
    func login() async {
        if isInputValid() {
            isLoading = true
            let result = await apiService.postLogin(with: .init(email: emailInput, password: passwordInput))
            isLoading = false
            
            switch result {
            case .success(let dto):
                (isLoginSuccess, isShowAlert) = handleSuccess(with: dto)
                if isLoginSuccess {
                    keychainService.saveToken(dto.token!)
                }
            case .failure(_):
                isShowAlert = true
            }
        }
    }
    
    private func handleSuccess(with dto: LoginResponseDto) -> (shouldGoDirectory: Bool, shouldShowAlert: Bool) {
        if let token = dto.token, !token.isEmpty {
            return (true, false)
        } else {
            return (false, true)
        }
    }
}


