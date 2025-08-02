//
//  RequestProtocol.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 2/8/2025.
//

import Foundation

protocol RequestProtocol {
    var method: HTTPMethod { get }
    var baseURL: URL { get }
    var path: String { get }
    var queryParams: [String: String]? { get }
    var body: [String: Any]? { get }
}

extension RequestProtocol {
    func create() throws -> URLRequest {
        var url = baseURL.appendingPathComponent(path)
        
        if let queryParams {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
            if let composedURL = components?.url {
                url = composedURL
            }
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if method == .POST, let body {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        return request
    }
}
