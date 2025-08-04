//
//  StaffDirectoryView.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 2/8/2025.
//

import SwiftUI

struct StaffDirectoryView: View {
    @State var viewModel = StaffDirectoryViewModel(apiService: APIService(), keychainService: KeychainService())
    @Environment(Router.self) private var router
    @Environment(\.modelContext) private var context
    
    var body: some View {
        List {
            ForEach(viewModel.staffs, id: \.id) { staff in
                StaffRowView(staff: staff)
                    .onAppear {
                        Task {
                           await viewModel.loadMoreIfNeeded(current: staff)
                        }
                    }
            }
            
            if viewModel.isLoadingMore {
                ProgressRowView()
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle(viewModel.token)
        .navigationBarBackButtonHidden(true)
        .task {
            viewModel.getToken()
            await viewModel.getUsers()
        }
        .onAppear {
            viewModel.setDatabaseService(DatabaseService(context: context))
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Logout") {
                    viewModel.logout()
                    router.popToRoot()
                }
            }
        }
    }
}

#Preview {
    StaffDirectoryView()
}
