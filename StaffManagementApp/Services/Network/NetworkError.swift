//
//  NetworkError.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 2/8/2025.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case invalidRequest
    case invalidResponse
    case decodingError
    case connectionError
    case clientError(Int)
    case serverError(Int)
    case unknownError(Int)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            "Invalid URL."
        case .invalidRequest:
            "Invalid URL request."
        case .invalidResponse:
            "Invalid server response."
        case .decodingError:
            "Failed to decode data."
        case .connectionError:
            "Connection error occurred."
        case .clientError(let statusCode):
            "Client error occurred. Status code: \(statusCode)."
        case .serverError(let statusCode):
            "Client error occurred. Status code: \(statusCode)."
        case .unknownError(let statusCode):
            "Unknown error occurred. Status code: \(statusCode)."
        }
    }
}
