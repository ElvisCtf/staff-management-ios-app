//
//  NetworkManager.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 2/8/2025.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
}

protocol NetworkManagerProtocol {
    func send<T: Decodable>(request: URLRequest, as type: T.Type) async -> Result<T, NetworkError>
}

final class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    private let session: URLSession
    
    private init(session: URLSession = .shared) {
        self.session = session
    }
    
    func send<T: Decodable>(request: URLRequest, as type: T.Type) async -> Result<T, NetworkError> {
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(.invalidResponse)
            }
            
            try validateResponse(httpResponse)
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return .success(decodedData)
            } catch {
                return .failure(.decodingError)
            }
            
        } catch {
            return .failure(.connectionError)
        }
    }
    
    private func validateResponse(_ response: HTTPURLResponse) throws {
        switch response.statusCode {
        case 200...299:
            ()
        case 400...499:
            throw NetworkError.clientError(response.statusCode)
        case 5000...599:
            throw NetworkError.serverError(response.statusCode)
        default:
            throw NetworkError.unknownError(response.statusCode)
        }
    }
}
