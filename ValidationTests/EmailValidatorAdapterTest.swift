//
//  ValidationTests.swift
//  ValidationTests
//
//  Created by Yannes Meneguelli on 19/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import XCTest
import PresentationLayer


public final class EmailValidatorAdapter: EmailValidator {
    
    private let patteern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
   public func isValid(email: String) -> Bool {
        let range = NSRange(location: 0, length: email.utf16.count)
        let rangex = try! NSRegularExpression(pattern: patteern)
        return rangex.firstMatch(in: email, options: [], range: range) != nil
        
    }
}





class EmailValidatorAdapterTest: XCTestCase {

    func test_invalid_emails() throws {
        let sut = EmailValidatorAdapter()
        XCTAssertFalse(sut.isValid(email: "rr"))
        XCTAssertFalse(sut.isValid(email: "rr@"))
        XCTAssertFalse(sut.isValid(email: "rr@rr"))
        XCTAssertFalse(sut.isValid(email: "rr@rr."))
        XCTAssertFalse(sut.isValid(email: "@rr.com"))
    }
}


//
//[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}
//
//
//func validateEmail(candidate: String) -> Bool {
// let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
// return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluateWithObject(candidate)
//}
