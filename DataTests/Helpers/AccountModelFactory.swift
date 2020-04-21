//
//  AccountModelFactory.swift
//  DataTests
//
//  Created by Yannes Meneguelli on 10/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation
import Domain

func makeAccountModel() -> AccountModel{
    return AccountModel(accessToken: "any_token")
 }


 func makeAddAccountModel() -> AddAccountModel{
    return AddAccountModel(name: "any_name", email: "any_email@hotmail.com", password: "any_password", passwordConfirmation: "any_password")
}
 
