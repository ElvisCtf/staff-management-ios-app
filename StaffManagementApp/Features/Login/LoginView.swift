//
//  LoginView.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 1/8/2025.
//

import SwiftUI

struct LoginView: View {
    @State private var viewModel = LoginViewModel()
    @FocusState private var focus: TextFieldFocus?
    
    var body: some View {
        VStack {
            Text("Welcome!")
                .font(.system(size: 22, weight: .semibold))
            
            Text("Please login to continue")
                .font(.system(size: 17, weight: .regular))
                .padding(.top, 4)
            
            TextField("Email", text: $viewModel.emailInput)
                .textFieldStyle(.roundedBorder)
                .focused($focus, equals: .email)
                .padding(.top, 16)
                .onSubmit {
                    viewModel.focus = .password
                }
            
            SecureField("Password", text: $viewModel.passwordInput)
                .textFieldStyle(.roundedBorder)
                .focused($focus, equals: .password)
                .padding(.top, 8)
                .onSubmit {
                    viewModel.focus = nil
                }
            
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
        .padding(24)
        .onChange(of: focus) { _, newValue in
            viewModel.focus = newValue
        }
        .onChange(of: viewModel.focus) { _, newValue in
            focus = newValue
        }
        .onAppear {
            viewModel.focus = .email
        }
    }
}

#Preview {
    LoginView()
}
