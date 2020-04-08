//
//  AddAccount.swift
//  Domain
//
//  Created by Yannes Meneguelli on 08/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation


protocol AddAccount{
    func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, Error>) -> Void)
}



struct AddAccountModel {
    var id:String
    var name: String
    var email: String
    var password: String
}
