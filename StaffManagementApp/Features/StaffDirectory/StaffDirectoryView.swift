//
//  StaffDirectoryView.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 2/8/2025.
//

import SwiftUI

struct StaffDirectoryView: View {
    @State private var viewModel = StaffDirectoryViewModel()
    
    var body: some View {
        Text("Staff Directory")
            .navigationTitle(viewModel.token)
            .navigationBarBackButtonHidden(true)
    }
}
