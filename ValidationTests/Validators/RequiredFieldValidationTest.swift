//
//  RequiredFieldValidation.swift
//  ValidationTests
//
//  Created by Yannes Meneguelli on 20/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//





import XCTest
import PresentationLayer
import Validation


class RequiredFieldValidationTest: XCTestCase {
    
    func test_validate_should_return_error_with_field_not_provided() throws {
        let sut = makeSut(fieldName:"email",fieldLabel: "Email")
        let errorMessage = sut.validate(data: ["name":"Yannes"])
        XCTAssertEqual(errorMessage, "O campo Email é obrigatorio")
    }
   
    
    func test_validate_should_return_error_with_correct_fieldLabel() throws {
        let sut = makeSut(fieldName:"age",fieldLabel: "Idade")
        let errorMessage = sut.validate(data: ["name":"Yannes"])
        XCTAssertEqual(errorMessage, "O campo Idade é obrigatorio")
    }
    
    func test_validate_should_return_nil_if_field_is_provided() throws {
          let sut = makeSut(fieldName:"email",fieldLabel: "Email")
          let errorMessage = sut.validate(data: ["email":"Yannes.meneguelli@gmail.com"])
          XCTAssertNil(errorMessage)
      }
    
    
    func test_validate_should_return_nil_if_no_data_is_provided() throws {
             let sut = makeSut(fieldName:"email",fieldLabel: "Email")
             let errorMessage = sut.validate(data: nil)
             XCTAssertEqual(errorMessage, "O campo Email é obrigatorio")
         }
    
}

extension RequiredFieldValidationTest {
    
    func makeSut(fieldName:String,fieldLabel:String,file: StaticString = #file, line: UInt = #line) -> Validation {
        let sut = RequiredFieldValidation(fieldName: fieldName, fieldLabel: fieldLabel)
        checkMemoryLeak(for: sut,file: file,line: line)
        return sut
    }
    
}



