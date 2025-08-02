//
//  LoginRequest.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 2/8/2025.
//

import Foundation

struct LoginRequest: RequestProtocol {
    let dto: LoginRequestDto
    
    var method: HTTPMethod { .POST }
    
    var baseURL: URL { Endpoints.baseURL }
    
    var path: String { String(format: Endpoints.login, "5") }
    
    var queryParams: [String : String]? {
        [
            "delay": "5"
        ]
    }
    
    var body: [String : Any]? {
        [
            "email" : dto.email,
            "password" : dto.password
        ]
    }
}
