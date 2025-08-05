//
//  LoginView.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 1/8/2025.
//

import SwiftUI

struct LoginView: View {
    @State private var viewModel = LoginViewModel(apiService: APIService(), keychainService: KeychainService())
    @FocusState private var focusedField: TextFieldType?
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


// MARK: - Subviews
extension LoginView {
    @ViewBuilder private var emailTextField: some View {
        FocusableTextField(
            input: $viewModel.emailInput,
            isValid: $viewModel.isEmailValid,
            focusBinding: $focusedField,
            type: .email,
            submitLabel: .next,
            onSubmit: { focusedField = .password }
        )
        .padding(.top, 16)
    }
    
    @ViewBuilder private var passwordTextField: some View {
        FocusableTextField(
            input: $viewModel.passwordInput,
            isValid: $viewModel.isPasswordValid,
            focusBinding: $focusedField,
            type: .password,
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

#Preview {
    LoginView()
        .withRouter()
}
