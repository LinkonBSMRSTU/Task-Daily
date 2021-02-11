//
//  UserRegistrationModelTests.swift
//  Task-DailyTests
//
//  Created by Fazle Rabbi Linkon on 12/2/21.
//  Copyright © 2021 Fazle Rabbi Linkon. All rights reserved.
//

import XCTest

import Foundation

struct UserRegistrationModel {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    let repeatPassword: String
}

class UserRegistrationModelTestCase: XCTestCase {
    
    var sut: UserRegistrationModelValidatorProtocol!
    let firstName = "Sergey"
    let lastName = "Kargopolov"
    let email = "test@test.com"
    let password = "12345678"
    let repeatPassword = "12345678"
    
    override func setUp() {
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func testUserModelStruc_canCreateNewInstance() {
        sut = UserRegistrationModel(firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        repeatPassword: repeatPassword)
        
        XCTAssertNotNil(sut)
     }
 
    func testUserFirstName_shouldPassIfValidFirstName() {
        sut = UserRegistrationModel(firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        repeatPassword: repeatPassword)
        
        XCTAssertTrue(sut.isValidFirstName())
     }
    
    func testUserFirstName_shouldPassIfFirstNameLessThanMinLength() {
        sut = UserRegistrationModel(firstName: "S",
        lastName: lastName,
        email: email,
        password: password,
        repeatPassword: repeatPassword)
        
        XCTAssertFalse(sut.isValidFirstName())
    }
    
    func testUserLastName_shouldPassIfValidLastName() {
        sut = UserRegistrationModel(firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        repeatPassword: repeatPassword)
        
        XCTAssertTrue(sut.isValidLastName())
    }
    
    func testUserLastName_shouldPassIfLastNameLessThanMinLength() {
        sut = UserRegistrationModel(firstName: firstName,
        lastName: "K",
        email: email,
        password: password,
        repeatPassword: repeatPassword)
        
        XCTAssertFalse(sut.isValidLastName())
    }
    
    func testUserRegistrationModel_shouldPassIfValidEmail() {
        sut = UserRegistrationModel(firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        repeatPassword: repeatPassword)
        
        XCTAssertTrue(sut.isValidEmail())
    }
    
    func testUserRegistrationModel_shouldPassIfInValidEmail() {
        
        sut = UserRegistrationModel(firstName: firstName,
        lastName: lastName,
        email: "test.com",
        password: password,
        repeatPassword: repeatPassword)
        
        XCTAssertFalse(sut.isValidEmail())
    }
    
    func testUserRegistrationModel_shouldPassIfValidPasswordLength() {
        sut = UserRegistrationModel(firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        repeatPassword: repeatPassword)
        
        XCTAssertTrue(sut.isValidPasswordLength())
    }
    
    func testUserPassword_passwordAndRepeatPasswordMustMatch() {
        sut = UserRegistrationModel(firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        repeatPassword: repeatPassword)
        
        XCTAssertTrue(sut.doPasswordsMatch())
    }
    
    func testUserPassword_shouldPassIfPasswordIsValid() {
        sut = UserRegistrationModel(firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        repeatPassword: repeatPassword)
        
        XCTAssertTrue(sut.isValidPassword())
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

