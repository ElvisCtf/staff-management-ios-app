//
//  LoadingButton.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 2/8/2025.
//

import SwiftUI

struct LoadingButton: View {
    @Binding var isLoading: Bool
    
    var title: String
    var font: Font
    var textColor: Color
    var backgroundColor: Color
    var disabledColor: Color = .gray
    var cornRadius: CGFloat = 8
    var height: CGFloat = 44
    var onPress: () -> Void = {}
    
    var body: some View {
        ZStack {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    onPress()
                }
            }) {
                Text(isLoading ? "" : title)
                    .font(font)
                    .foregroundColor(textColor)
                    .frame(maxWidth: .infinity, maxHeight: height)
                    .background(isLoading ? disabledColor : backgroundColor)
                    .cornerRadius(cornRadius)
            }.disabled(isLoading)
            
            if isLoading {
                ProgressView()
                    .tint(.white)
                    .progressViewStyle(.circular)
            }
        }
    }
}

#Preview {
    @Previewable @State var isLoading = false
    
    LoadingButton(
        isLoading: $isLoading,
        title: "Log In",
        font: .system(size: 17, weight: .medium),
        textColor: .white,
        backgroundColor: .blue,
        disabledColor: .blue.opacity(0.6)
    )
}
