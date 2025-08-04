//
//  ProgressRowView.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 3/8/2025.
//

import SwiftUI

struct ProgressRowView: View {
    var body: some View {
        HStack {
            Spacer()
            ProgressView()
                .tint(.blue)
                .scaleEffect(1.2)
            Spacer()
        }
        .padding(16)
    }
}

#Preview {
    ProgressRowView()
}
