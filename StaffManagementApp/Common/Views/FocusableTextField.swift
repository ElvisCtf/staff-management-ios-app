//
//  FocusableTextField.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 2/8/2025.
//

import SwiftUI

struct FocusableTextField: View {
    @State private var isInvalid = false
    
    @Binding var input: String
    var title: String
    var isSecure: Bool = false
    var keyboardType : UIKeyboardType = .default
    var errorMessage: String = ""
    var submitLabel: SubmitLabel = .done
    var focusTag: TextFieldFocus
    var focusBinding: FocusState<TextFieldFocus?>.Binding
    var onSubmit: () -> Void = { }
    
    var body: some View {
        VStack {
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
            .keyboardType(keyboardType)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .submitLabel(submitLabel)
            .onSubmit(onSubmit)
            
            if isInvalid {
                Text(errorMessage)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.red)
                    .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
