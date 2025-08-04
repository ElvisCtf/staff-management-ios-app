//
//  LoginView.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 1/8/2025.
//

import SwiftUI

struct LoginView: View {
    @State private var viewModel = LoginViewModel(apiService: APIService(), keychainService: KeychainService())
    @FocusState private var focusedField: TextFieldFocus?
    @Environment(Router.self) private var router
    
    var body: some View {
        VStack {
            Text("Welcome!")
                .font(.system(size: 22, weight: .semibold))
            
            Text("Please log in to continue")
                .font(.system(size: 17, weight: .regular))
                .padding(.top, 4)
            
            emailTextField
            
            passwordTextField
            
            loginButton
        }
        .padding(24)
        .onAppear {
            viewModel.isLoginSuccess = viewModel.checkTokenExist()
            focusedField = .email
        }
        .onChange(of: viewModel.isLoginSuccess) {
            goToStaffDirectory(isLoginSuccess: viewModel.isLoginSuccess)
        }
        .retryAlert(isPresented: $viewModel.isShowAlert) {
            Task {
               await login()
            }
        }
    }
    
}


// MARK: - Methods
extension LoginView {
    private func focusEmail() {
        DispatchQueue.main.async {
            focusedField = .email
        }
    }
    
    private func goToStaffDirectory(isLoginSuccess: Bool) {
        if isLoginSuccess {
            router.navigateToStaffDirectory()
        }
    }
    
    private func login() async {
        if viewModel.isInputValid() {
            await viewModel.login()
        }
    }
}


// MARK: - Subviews
extension LoginView {
    @ViewBuilder private var emailTextField: some View {
        FocusableTextField(
            input: $viewModel.emailInput,
            isValid: $viewModel.isEmailValid,
            title: "email",
            errorMessage: "Your email is incorrect.",
            keyboardType: .emailAddress,
            submitLabel: .next,
            focusTag: .email,
            focusBinding: $focusedField,
            validate: { $0.isEmail },
            onSubmit: { focusedField = .password }
        )
        .padding(.top, 16)
    }
    
    @ViewBuilder private var passwordTextField: some View {
        FocusableTextField(
            input: $viewModel.passwordInput,
            isValid: $viewModel.isPasswordValid,
            title: "password",
            errorMessage: "Your password should be letter and number only,\nand 6 to 10 characters long.",
            isSecure: true,
            keyboardType: .asciiCapable,
            focusTag: .password,
            focusBinding: $focusedField,
            validate: { $0.isPassword },
            onSubmit: { focusedField = nil }
        )
        .padding(.top, 8)
    }
    
    @ViewBuilder private var loginButton: some View {
        LoadingButton(
            isLoading: $viewModel.isLoading,
            title: "Log In",
            font: .system(size: 17, weight: .medium),
            textColor: .white,
            backgroundColor: .blue,
            disabledColor: .blue.opacity(0.6),
            onPress: {
                viewModel.updateValidState()
                Task {
                    await login()
                }
            }
        )
        .padding(.top, 16)
    }
}

#Preview {
    LoginView()
        .withRouter()
}
