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
        let sut = LoginViewModel(apiService: ValidLoginAPIService(), keychainService: mockKeychainService)
        sut.isEmailValid = true
        sut.isPasswordValid = true
        
        await sut.login()
        
        #expect(sut.isLoginSuccess == true)
        #expect(sut.isShowAlert == false)
    }
    
    @Test func testReceiveEmptyToken() async {
        let sut = LoginViewModel(apiService: EmptyLoginAPIService(), keychainService: mockKeychainService)
        sut.isEmailValid = true
        sut.isPasswordValid = true
        
        await sut.login()
        
        #expect(sut.isLoginSuccess == false)
        #expect(sut.isShowAlert == true)
    }
    
    @Test func testReceiveNilToken() async {
        let sut = LoginViewModel(apiService: NilLoginAPIService(), keychainService: mockKeychainService)
        sut.isEmailValid = true
        sut.isPasswordValid = true
        
        await sut.login()
        
        #expect(sut.isLoginSuccess == false)
        #expect(sut.isShowAlert == true)
    }
    
    @Test func testReceiveError() async {
        let sut = LoginViewModel(apiService: ErrorLoginAPIService(), keychainService: mockKeychainService)
        sut.isEmailValid = true
        sut.isPasswordValid = true
        
        await sut.login()
        
        #expect(sut.isLoginSuccess == false)
        #expect(sut.isShowAlert == true)
    }
}


final class ValidLoginAPIService: LoginAPIServiceProtocol {
    func postLogin(with dto: StaffManagementApp.LoginRequestDto) async -> Result<StaffManagementApp.LoginResponseDto, StaffManagementApp.NetworkError> {
        return .success(LoginResponseDto(token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"))
    }
}


final class EmptyLoginAPIService: LoginAPIServiceProtocol {
    func postLogin(with dto: StaffManagementApp.LoginRequestDto) async -> Result<StaffManagementApp.LoginResponseDto, StaffManagementApp.NetworkError> {
        return .success(LoginResponseDto(token: ""))
    }
}


final class NilLoginAPIService: LoginAPIServiceProtocol {
    func postLogin(with dto: StaffManagementApp.LoginRequestDto) async -> Result<StaffManagementApp.LoginResponseDto, StaffManagementApp.NetworkError> {
        return .success(LoginResponseDto(token: nil))
    }
}


final class ErrorLoginAPIService: LoginAPIServiceProtocol {
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
