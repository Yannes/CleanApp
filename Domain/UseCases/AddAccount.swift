//
//  AddAccount.swift
//  Domain
//
//  Created by Yannes Meneguelli on 08/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation


public protocol AddAccount{
    typealias Result = Swift.Result<AccountModel, DomainError>
    func add(addAccountModel: AddAccountModel, completion: @escaping (Result) -> Void)
}



public struct AddAccountModel: Model {
   public  var name: String
   public  var email: String
   public  var password: String
   public  var passwordConfirmation: String
    
    public init(name: String,email: String,password: String,passwordConfirmation: String){
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation =  passwordConfirmation
    }
}




