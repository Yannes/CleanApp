//
//  SignUpIntegrationTest.swift
//  MainTests
//
//  Created by Yannes Meneguelli on 19/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import XCTest
import Main
import Validation
import UI

class SignUpComposerTest: XCTestCase {
    
    func test_backgorund_request_should_complete_on_main_thread() throws {
       let (sut,addAccountSpy) = makeSut()
        sut.loadViewIfNeeded()
        sut.signUp?(makesignUpViewModel())
        let exp = expectation(description: "Waiting")
        DispatchQueue.global().async {
            addAccountSpy.completeWithError(.unexpected)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
    
    
    func test_signUp_compose_with_correct_validations(){
        
        let validations = makesignUpValidation()
        XCTAssertEqual(validations[0] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "name", fieldLabel: "Nome"))
        XCTAssertEqual(validations[1] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"))
        XCTAssertEqual(validations[2] as! EmailValidation, EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorSpy()))
        XCTAssertEqual(validations[3] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha"))
        XCTAssertEqual(validations[4] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "passwordConfirmation", fieldLabel: "Confirmar Senha"))
        XCTAssertEqual(validations[5] as! CompareFieldsValidation, CompareFieldsValidation(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Confirmar Senha"))
    }
}

extension SignUpComposerTest{
    func makeSut(file: StaticString = #file, line: UInt = #line) ->(sut: SignUpViewController, addAccountSpy:AddAccountSpy){
      let addAccountSpy = AddAccountSpy()
      let sut = makeSignUpController(addAccount:  MainQueueDispatchDecorator(addAccountSpy))
      checkMemoryLeak(for: sut, file: file, line: line)
      checkMemoryLeak(for: addAccountSpy,file: file, line: line)
      return (sut, addAccountSpy)
    }
}
