//
//  ValidationTests.swift
//  ValidationTests
//
//  Created by Yannes Meneguelli on 19/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import XCTest
import PresentationLayer
import Validation

class EmailValidatorAdapterTest: XCTestCase {

    func test_invalid_emails() throws {
        let sut = makeSut()
        XCTAssertFalse(sut.isValid(email: "rr"))
        XCTAssertFalse(sut.isValid(email: "rr@"))
        XCTAssertFalse(sut.isValid(email: "rr@rr"))
        XCTAssertFalse(sut.isValid(email: "rr@rr."))
        XCTAssertFalse(sut.isValid(email: "@rr.com"))
    }
    
    func test_valid_emails() throws {
        let sut = makeSut()
        XCTAssertTrue(sut.isValid(email: "yannes@gmail.com"))
        XCTAssertTrue(sut.isValid(email: "yannes@hotmail.com"))
        XCTAssertTrue(sut.isValid(email: "yannes@terra.com.br"))
    }
}


extension EmailValidatorAdapterTest{
    func makeSut() -> EmailValidatorAdapter{
        return EmailValidatorAdapter()
    }
}
