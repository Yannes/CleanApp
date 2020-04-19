//
//  EmailValidatorAdapter.swift
//  Validation
//
//  Created by Yannes Meneguelli on 19/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation
import PresentationLayer


public final class EmailValidatorAdapter: EmailValidator {
    
   private let patteern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
   
   public init() {}
    
   public func isValid(email: String) -> Bool {
        let range = NSRange(location: 0, length: email.utf16.count)
        let rangex = try! NSRegularExpression(pattern: patteern)
        return rangex.firstMatch(in: email, options: [], range: range) != nil
        
    }
}

