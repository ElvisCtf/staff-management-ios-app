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
    
    var isInputValid: Bool { isEmailValid == true && isPasswordValid == true }
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
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
        
        if isInputValid {
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
            
        } else {
            isShowAlert = true
        }
    }
    
    private func handError(with error: NetworkError) {
        isShowAlert = true
    }

}


