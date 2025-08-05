//
//  FocusableTextField.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 2/8/2025.
//

import SwiftUI

struct FocusableTextField: View {
    @State var isSecure: Bool = true
    @Binding var input: String
    @Binding var isValid: Bool?
    var focusBinding: FocusState<TextFieldType?>.Binding
   
    var type: TextFieldType
    var submitLabel: SubmitLabel = .done
    var onSubmit: () -> Void = { }
    
    var body: some View {
        VStack {
            HStack {
                Group {
                    if type == .password && isSecure {
                        SecureField(type.placeholder, text: $input)
                            .focused(focusBinding, equals: type)
                    } else {
                        TextField(type.placeholder, text: $input)
                            .focused(focusBinding, equals: type)
                    }
                }
                .textFieldStyle(.plain)
                .keyboardType(type.keyboardType)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .submitLabel(submitLabel)
                .onChange(of: input) { _, newValue in
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isValid = type.validator(newValue)
                    }
                }
                .onSubmit(onSubmit)
                .padding(EdgeInsets(top: 16, leading: 12, bottom: 16, trailing: 12))
                
                if type == .password {
                    Button(action: {
                        isSecure.toggle()
                    }) {
                        Image(systemName: isSecure ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 12)
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(.gray, lineWidth: 1)
            )
            
            if isValid == false {
                Text(type.errorMessage)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.red)
                    .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    @Previewable @State var input: String = ""
    @Previewable @State var isValid: Bool? = false
    @FocusState var focusedField: TextFieldType?
    
    FocusableTextField(
        input: $input,
        isValid: $isValid,
        focusBinding: $focusedField,
        type: .password
    )
    .padding(16)
}
