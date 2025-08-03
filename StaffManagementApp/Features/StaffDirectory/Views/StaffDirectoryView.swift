//
//  StaffDirectoryView.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 2/8/2025.
//

import SwiftUI

struct StaffDirectoryView: View {
    @State var viewModel = StaffDirectoryViewModel()
    
    var body: some View {
        List(viewModel.staffs) { staff in
            StaffRowView(staff: staff)
        }
        .listStyle(.insetGrouped)
        .navigationTitle(viewModel.token)
        .navigationBarBackButtonHidden(true)
        .task {
            await viewModel.getUsers()
        }
    }
}

#Preview {
    StaffDirectoryView()
}
