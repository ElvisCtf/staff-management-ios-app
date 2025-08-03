//
//  FocusableTextField.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 2/8/2025.
//

import SwiftUI

struct FocusableTextField: View {
    @Binding var input: String
    @State var isValid: Bool? = nil
    
    var title: String
    var errorMessage: String
    var isSecure: Bool = false
    var keyboardType : UIKeyboardType = .default
    var submitLabel: SubmitLabel = .done
    var focusTag: TextFieldFocus
    var focusBinding: FocusState<TextFieldFocus?>.Binding
    var validate: (String) -> Bool
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
            .onChange(of: input) { _, newValue in
                withAnimation(.easeInOut(duration: 0.3)) {
                    isValid = validate(newValue)
                }
            }
            .onSubmit(onSubmit)
            
            if isValid == false {
                Text(errorMessage)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.red)
                    .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
