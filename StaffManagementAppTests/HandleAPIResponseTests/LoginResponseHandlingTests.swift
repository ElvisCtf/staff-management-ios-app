//
//  LoginResponseHandlingTests.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 5/8/2025.
//

import Testing
@testable import StaffManagementApp

struct LoginResponseHandlingTests {
    let mockKeychainService = MockKeychainService()
    
    @Test func testReceiveValidToken() async {
        let sut = LoginViewModel(apiService: ValidLoginApiService(), keychainService: mockKeychainService)
        sut.isEmailValid = true
        sut.isPasswordValid = true
        
        await sut.login()
        
        #expect(sut.isLoginSuccess == true)
        #expect(sut.isShowAlert == false)
    }
    
    @Test func testReceiveEmptyToken() async {
        let sut = LoginViewModel(apiService: EmptyLoginApiService(), keychainService: mockKeychainService)
        sut.isEmailValid = true
        sut.isPasswordValid = true
        
        await sut.login()
        
        #expect(sut.isLoginSuccess == false)
        #expect(sut.isShowAlert == true)
    }
    
    @Test func testReceiveNilToken() async {
        let sut = LoginViewModel(apiService: NilLoginApiService(), keychainService: mockKeychainService)
        sut.isEmailValid = true
        sut.isPasswordValid = true
        
        await sut.login()
        
        #expect(sut.isLoginSuccess == false)
        #expect(sut.isShowAlert == true)
    }
    
    @Test func testReceiveError() async {
        let sut = LoginViewModel(apiService: ErrorLoginApiService(), keychainService: mockKeychainService)
        sut.isEmailValid = true
        sut.isPasswordValid = true
        
        await sut.login()
        
        #expect(sut.isLoginSuccess == false)
        #expect(sut.isShowAlert == true)
    }
}


final class ValidLoginApiService: LoginAPIServiceProtocol {
    func postLogin(with dto: StaffManagementApp.LoginRequestDto) async -> Result<StaffManagementApp.LoginResponseDto, StaffManagementApp.NetworkError> {
        return .success(LoginResponseDto(token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"))
    }
}


final class EmptyLoginApiService: LoginAPIServiceProtocol {
    func postLogin(with dto: StaffManagementApp.LoginRequestDto) async -> Result<StaffManagementApp.LoginResponseDto, StaffManagementApp.NetworkError> {
        return .success(LoginResponseDto(token: ""))
    }
}


final class NilLoginApiService: LoginAPIServiceProtocol {
    func postLogin(with dto: StaffManagementApp.LoginRequestDto) async -> Result<StaffManagementApp.LoginResponseDto, StaffManagementApp.NetworkError> {
        return .success(LoginResponseDto(token: nil))
    }
}


final class ErrorLoginApiService: LoginAPIServiceProtocol {
    func postLogin(with dto: StaffManagementApp.LoginRequestDto) async -> Result<StaffManagementApp.LoginResponseDto, StaffManagementApp.NetworkError> {
        return .failure(.connectionError)
    }
}


final class MockKeychainService: KeychainServiceProtocol {
    func saveToken(_ token: String) {
    }
    
    func readToken() -> String? {
        return "token"
    }
    
    func deleteToken() {
    }
    
    
}
