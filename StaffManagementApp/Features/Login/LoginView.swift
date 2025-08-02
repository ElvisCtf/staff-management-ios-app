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
            
            Text("Please login to continue")
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
    }
}

// MARK: - Subviews
extension LoginView {
    @ViewBuilder private var EmailTextField: some View {
        FocusableTextField(
            input: $viewModel.emailInput,
            title: "email",
            keyboardType: .emailAddress,
            submitLabel: .next,
            focusTag: .email,
            focusBinding: $focusedField,
            onSubmit: { focusedField = .password }
        )
        .padding(.top, 16)
    }
    
    @ViewBuilder private var PasswordTextField: some View {
        FocusableTextField(
            input: $viewModel.passwordInput,
            title: "password",
            isSecure: false,
            keyboardType: .asciiCapable,
            focusTag: .password,
            focusBinding: $focusedField,
            onSubmit: { focusedField = nil }
        )
        .padding(.top, 8)
    }
    
    @ViewBuilder private var LoginButton: some View {
        Button(action: {
            
        }) {
            Text("Login")
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: 44)
                .background(Color.blue)
                .cornerRadius(8)
        }
        .padding(.top, 16)
    }
}

#Preview {
    LoginView()
}
