//
//  PasswordValidationTests.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 5/8/2025.
//

import Testing
@testable import StaffManagementApp

struct PasswordValidationTests {
    @Test func testValidPasswords() {
        #expect("abc123".isPassword == true)
        #expect("A1B2C3".isPassword == true)
        #expect("123456".isPassword == true)
        #expect("abcdef".isPassword == true)
    }

    @Test func testInvalidDueToLength() {
        // Less than 6 characters
        #expect("abc12".isPassword == false)
        
        // More than 10 characters
        #expect("abcdefghijk".isPassword == false)
    }

    @Test func testInvalidDueToCharacters() {
        // Contains special character at the end
        #expect("abc123!".isPassword == false)
        
        // Contains special character in middle
        #expect("abc_123".isPassword == false)
        
        // Contains special character at the start
        #expect("@abc123".isPassword == false)
        
        // Contains space
        #expect("abc 123".isPassword == false)
        
        // Contains only special characters
        #expect("~!@#$%^&*()_+{}|:\"?>< ".isPassword == false)
    }

    @Test func testEmptyString() {
        #expect("".isPassword == false)
    }
    
    @Test func testIsAlphaNumeric() {
        #expect("abc123".isAlphaNumeric == true)
        #expect("abcdef".isAlphaNumeric == true)
        #expect("123456".isAlphaNumeric == true)
    }
    
    @Test func testNoAlphaNumeric() {
        #expect("".isAlphaNumeric == false)
        #expect("abc123!".isAlphaNumeric == false)
        #expect("abc 123".isAlphaNumeric == false)
    }
}

