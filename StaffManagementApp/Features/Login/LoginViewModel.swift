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
    
    private let apiService: APIServiceProtocol
    private let keychainService: KeychainServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService(), keychainService: KeychainServiceProtocol = KeychainService()) {
        self.apiService = apiService
        self.keychainService = keychainService
    }
    
    func validateEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    func validatePassword(_ password: String) -> Bool {
        let isLength6To10 = password.count >= 6 && password.count <= 10
        let isAlphaNumeric = password.isAlphaNumeric
        return isLength6To10 && isAlphaNumeric
    }
    
    func login() async {
        isEmailValid = validateEmail(emailInput)
        isPasswordValid = validatePassword(passwordInput)
        
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


