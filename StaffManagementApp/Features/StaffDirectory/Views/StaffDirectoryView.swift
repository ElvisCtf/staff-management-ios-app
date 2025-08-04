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
            switch viewModel.state {
            case .empty:
                emptyView
            case .hasData:
                staffListView
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle(viewModel.token)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.getToken()
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


// MARK: - Subviews
extension StaffDirectoryView {
    @ViewBuilder private var emptyView: some View {
        Text("No colleague found.")
            .frame(maxWidth: .infinity, alignment: .center)
            .onAppear {
                Task {
                    await viewModel.getUsers()
                }
            }
    }
    
    @ViewBuilder private var staffListView: some View {
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
}

#Preview {
    StaffDirectoryView()
}
