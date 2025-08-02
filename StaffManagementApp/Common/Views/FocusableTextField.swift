//
//  FocusableTextField.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 2/8/2025.
//

import SwiftUI

struct FocusableTextField: View {
    @Binding var input: String
    var title: String
    var isSecure: Bool
    var submitLabel: SubmitLabel = .done
    var focusTag: TextFieldFocus
    var focusBinding: FocusState<TextFieldFocus?>.Binding
    var onSubmit: () -> Void = { }
    
    var body: some View {
        Group {
            if isSecure {
                SecureField(title, text: $input)
                    .focused(focusBinding, equals: focusTag)
            } else {
                TextField(title, text: $input)
                    .focused(focusBinding, equals: focusTag)
            }
        }
        .textFieldStyle(.roundedBorder)
        .submitLabel(submitLabel)
        .onSubmit(onSubmit)
    }
}
