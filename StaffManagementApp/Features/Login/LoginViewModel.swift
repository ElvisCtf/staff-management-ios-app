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
    var isEmailValid: Bool? = nil
    var isPasswordValid: Bool? = nil
    var isLoading = false
    var isShowAlert = false
    var isLoginSuccess = false
    
    @ObservationIgnored private let apiService: APIServiceProtocol
    @ObservationIgnored private let keychainService: KeychainServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService(), keychainService: KeychainServiceProtocol = KeychainService()) {
        self.apiService = apiService
        self.keychainService = keychainService
    }
    
    func validateFields() -> Bool {
        isEmailValid = emailInput.isEmail
        isPasswordValid = passwordInput.isPassword
        return isEmailValid == true && isPasswordValid == true
    }
    
    func login() async {
        if isEmailValid == true && isPasswordValid == true {
            isLoading = true
            let result = await apiService.postLogin(with: .init(email: emailInput, password: passwordInput))
            isLoading = false
            
            switch result {
            case .success(let dto):
                handleSuccess(with: dto)
            case .failure(let error):
                handError(with: error)
            }
        }
    }
    
    private func handleSuccess(with dto: LoginResponseDto) {
        if let token = dto.token, !token.isEmpty {
            keychainService.saveToken(token)
            isLoginSuccess = true
        } else {
            isShowAlert = true
        }
    }
    
    private func handError(with error: NetworkError) {
        isShowAlert = true
    }

}


