//
//  KeychainService.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 2/8/2025.
//

import Foundation

protocol KeychainServiceProtocol {
    func saveToken(_ token: String)
    func readToken() -> String?
    func deleteToken()
}

final class KeychainService: KeychainServiceProtocol {
    private let service = "\(Bundle.main.bundleIdentifier ?? "com.elvis.StaffManagementApp").token"
    private let account = "token"
    
    
    func saveToken(_ token: String) {
        if let data = token.data(using: .utf8) {
            KeychainHelper.shared.save(data, service: service, account: account)
        }
    }
    
    func readToken() -> String? {
        if let data = KeychainHelper.shared.read(service: service, account: account),
           let token = String(data: data, encoding: .utf8) {
            return token
        }
        return nil
    }

    func deleteToken() {
        KeychainHelper.shared.delete(service: service, account: account)
    }

}
