//
//  UsersResponseDto.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 3/8/2025.
//

struct UsersResponseDto: Decodable {
    let page: Int
    let perPage: Int
    let total: Int
    let totalPages: Int
    let users: [User]

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case users = "data"
    }
}

struct User: Decodable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}
