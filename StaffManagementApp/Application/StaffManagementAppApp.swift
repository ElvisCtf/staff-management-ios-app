//
//  StaffManagementAppApp.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 1/8/2025.
//

import SwiftUI
import SwiftData

@main
struct StaffManagementAppApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView()
                .withRouter()
        }
        .modelContainer(for: [Staff.self])
    }
}
