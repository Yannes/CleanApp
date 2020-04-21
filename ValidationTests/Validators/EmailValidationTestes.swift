//
//  EmailValidationTestes.swift
//  ValidationTests
//
//  Created by Yannes Meneguelli on 21/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation
import XCTest
import PresentationLayer
import Validation

class EmailValidationTestes: XCTestCase {
    
    func test_validate_should_return_error_if_invalid_email_is_provided() throws {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(fieldName: "email",fieldLabel: "Email",emailValidator:emailValidatorSpy)
        emailValidatorSpy.simulateInvalidEmail()
        let errorMessage = sut.validate(data: ["email":"invalid_email@gmail.com"])
        XCTAssertEqual(errorMessage, "O campo Email é invalido")
    }
    
    func test_validate_should_return_error_with_correct_fieldLabel() throws {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(fieldName: "email",fieldLabel: "Email2",emailValidator:emailValidatorSpy)
        emailValidatorSpy.simulateInvalidEmail()
        let errorMessage = sut.validate(data: ["email":"invalid_email@gmail.com"])
        XCTAssertEqual(errorMessage, "O campo Email2 é invalido")
    }
    
    
    func test_validate_should_return_nil_if_invalid_email_is_provided() throws {
        let sut = makeSut(fieldName: "email",fieldLabel: "Email2",emailValidator:EmailValidatorSpy())
        let errorMessage = sut.validate(data: ["email":"invalid_email@gmail.com"])
        XCTAssertNil(errorMessage)
    }
    
    
    func test_validate_should_return_nil_if_no_data_is_provided() throws {
        let sut = makeSut(fieldName: "email",fieldLabel: "Email",emailValidator:EmailValidatorSpy())
        let errorMessage = sut.validate(data: nil)
        XCTAssertEqual(errorMessage, "O campo Email é invalido")
    }
}


extension EmailValidationTestes {
    
    func makeSut(fieldName:String,fieldLabel:String,emailValidator:EmailValidatorSpy,file: StaticString = #file, line: UInt = #line) -> Validation {
        let sut = EmailValidation(fieldName: fieldName, fieldLabel: fieldLabel, emailValidator: emailValidator)
        checkMemoryLeak(for: sut,file: file,line: line)
        return sut
    }
    
}
