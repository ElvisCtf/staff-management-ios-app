//
//  RetryAlertViewModifier.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 3/8/2025.
//

import SwiftUI

struct RetryAlertViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    let retry: () -> Void

    func body(content: Content) -> some View {
        content
            .alert("Error", isPresented: $isPresented) {
                Button("Retry") {
                    retry()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Failed to log in.\nDo you want to try again?")
            }
    }
}


extension View {
    func retryAlert(isPresented: Binding<Bool>, retry: @escaping () -> Void) -> some View {
        self.modifier(RetryAlertViewModifier(isPresented: isPresented, retry: retry))
    }
}
