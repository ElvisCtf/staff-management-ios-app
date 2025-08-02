//
//  LoginView.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 1/8/2025.
//

import SwiftUI

struct LoginView: View {
    @State private var viewModel = LoginViewModel()
    @FocusState private var focusedField: TextFieldFocus?
    
    var body: some View {
        VStack {
            Text("Welcome!")
                .font(.system(size: 22, weight: .semibold))
            
            Text("Please log in to continue")
                .font(.system(size: 17, weight: .regular))
                .padding(.top, 4)
            
            EmailTextField
            
            PasswordTextField
            
            LoginButton
        }
        .padding(24)
        .onAppear {
            focusedField = .email
        }
        .alert("Error", isPresented: $viewModel.isShowAlert) {
            Button("Retry") {
                Task {
                   await viewModel.login()
                }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Failed to log in.\nDo you want to try again?")
        }
    }
}

// MARK: - Subviews
extension LoginView {
    @ViewBuilder private var EmailTextField: some View {
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
    
    @ViewBuilder private var PasswordTextField: some View {
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
    
    @ViewBuilder private var LoginButton: some View {
        LoadingButton(
            isLoading: $viewModel.isLoading,
            title: "Log In",
            font: .system(size: 17, weight: .medium),
            textColor: .white,
            backgroundColor: .blue,
            disabledColor: .blue.opacity(0.6),
            onPress: {
                Task {
                    await viewModel.login()
                }
            }
        )
        .padding(.top, 16)
    }
}

#Preview {
    LoginView()
}
