//
//  UsersRequest.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 3/8/2025.
//

import Foundation

struct UsersRequest: RequestProtocol {
    let page: Int
    
    var method: HTTPMethod { .GET }
    
    var baseURL: URL { Endpoints.baseURL }
    
    var path: String { Endpoints.users }
    
    var queryParams: [String : String]? {
        [
            "page": "\(page)"
        ]
    }
    
    var body: [String : Any]? {
        nil
    }
}
