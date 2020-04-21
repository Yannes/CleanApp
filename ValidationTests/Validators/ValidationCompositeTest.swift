//
//  ValidationCompositeTest.swift
//  ValidationTests
//
//  Created by Yannes Meneguelli on 21/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation
import XCTest
import PresentationLayer
import Validation


class ValidationCompositeTest: XCTestCase {
    
    func test_validate_should_return_error_if_validation_fails() throws {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validations: [validationSpy])
        validationSpy.simulateError("Erro 1")
        let errorMessage = sut.validate(data: ["name":"Yannes"])
        XCTAssertEqual(errorMessage, "Erro 1")
    }
    
    
    func test_validate_should_return_correct_error_message() throws {
        let validationSpy2 = ValidationSpy()
        let sut = makeSut(validations: [ValidationSpy(),validationSpy2])
        validationSpy2.simulateError("Erro 3")
        let errorMessage = sut.validate(data: ["name":"Yannes"])
        XCTAssertEqual(errorMessage, "Erro 3")
    }
    
    func test_validate_should_return_the_first_error_message() throws {
           let validationSpy2 = ValidationSpy()
           let validationSpy3 = ValidationSpy()
           let sut = makeSut(validations: [ValidationSpy(),validationSpy2,validationSpy3])
           validationSpy2.simulateError("Erro 2")
           validationSpy3.simulateError("Erro 3")
           let errorMessage = sut.validate(data: ["name":"Yannes"])
           XCTAssertEqual(errorMessage, "Erro 2")
       }
    
    func test_validate_should_return_nil_if_validation_succeeds() throws {
           let sut = makeSut(validations: [ValidationSpy()])
           let errorMessage = sut.validate(data: ["name":"Yannes"])
           XCTAssertNil(errorMessage)
           
       }
    
    func test_validate_should_call_validaton_with_correct_data() throws {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validations: [validationSpy])
        let data = ["name":"Yannes"]
        _ = sut.validate(data: data )
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: data))
        
    }
}


extension ValidationCompositeTest {
    
    func makeSut(validations: [ValidationSpy],file: StaticString = #file, line: UInt = #line) -> Validation {
        let sut = ValidationComposite(validations:validations)
        checkMemoryLeak(for: sut,file: file,line: line)
        return sut
    }
    
}
