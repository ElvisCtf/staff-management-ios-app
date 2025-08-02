//
//  Router.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 3/8/2025.
//

import SwiftUI

@Observable final class Router {
    var path = NavigationPath()
    
    func navigateToStaffDirectory() {
        path.append(Route.staffDirectory)
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}

enum Route: Hashable {
    case staffDirectory
}
