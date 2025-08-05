//
//  EmailValidationTests.swift
//  StaffManagementApp
//
//  Created by Elvis Cheng on 5/8/2025.
//

import Testing
@testable import StaffManagementApp

struct EmailValidationTests {
    @Test func testValidEmail() {
        #expect("user@example.com".isEmail == true)
        #expect("user.name+tag+sorting@example.com".isEmail == true)
        #expect("user_name@example.co.uk".isEmail == true)
        #expect("user123@example.io".isEmail == true)
        #expect("user-name@example.travel".isEmail == true)
    }
    
    @Test func testInvalidEmail() {
        // Missing @ and domain
        #expect("plainaddress".isEmail == false)
        
        // Missing local part
        #expect("@no-local-part.com".isEmail == false)
        
        // Domain starts with dot
        #expect("user@.com".isEmail == false)
        
        // Missing dot in domain
        #expect("user@com".isEmail == false)
        
        // Double dot in domain
        #expect("user@domain..com".isEmail == false)
        
        // Top-Level Domain too short (less than 1)
        #expect("user@domain.c".isEmail == false)
        
        // Top-Level Domain too long (more than 63)
        #expect("user@domain.zebronifluxamorticalvenquistradomexalithoparvundelocryptomaxivex".isEmail == false)
        
        // Comma instead of dot
        #expect("user@domain,com".isEmail == false)
        
        // Multiple @ symbols
        #expect("user@domain@domain.com".isEmail == false)
        
        // Space in local part
        #expect("user name@example.com".isEmail == false)
    }
}
