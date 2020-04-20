//
//  SignUpIntegrationTest.swift
//  MainTests
//
//  Created by Yannes Meneguelli on 19/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import XCTest
import Main
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
}


extension SignUpComposerTest{
    func makeSut(file: StaticString = #file, line: UInt = #line) ->(sut: SignUpViewController, addAccountSpy:AddAccountSpy){
      let addAccountSpy = AddAccountSpy()
      let sut = SignUpComposer.composeControllerWith(addAccount:  MainQueueDispatchDecorator(addAccountSpy))
      checkMemoryLeak(for: sut, file: file, line: line)
      checkMemoryLeak(for: addAccountSpy,file: file, line: line)
      return (sut, addAccountSpy)
    }
}
