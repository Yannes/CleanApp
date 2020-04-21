//
//  EmailValidatorSpy.swift
//  PresentationLayerTests
//
//  Created by Yannes Meneguelli on 17/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation
import Validation


class EmailValidatorSpy: EmailValidator{
    var isvalid = true
    var email:String?
    
    func isValid(email:String) ->Bool{
        self.email = email
        return isvalid
    }
    
    func simulateInvalidEmail(){
        isvalid = false
    }  
}
