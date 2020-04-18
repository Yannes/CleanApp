//
//  SignUpViewModel.swift
//  PresentationLayer
//
//  Created by Yannes Meneguelli on 17/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation
import Domain


public struct SignUpViewModel:Model{
    public  var name: String?
    public  var email: String?
    public  var password: String?
    public  var passwordConfirmation: String?
    
    
    public init(name:String? = nil, email:String? = nil, password:String? = nil, passwordConfirm:String? = nil){
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirm
    }
}
