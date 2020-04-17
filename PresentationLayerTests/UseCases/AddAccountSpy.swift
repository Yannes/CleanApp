//
//  AddAccountSpy.swift
//  PresentationLayerTests
//
//  Created by Yannes Meneguelli on 17/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation
import Domain
import PresentationLayer

class AddAccountSpy: AddAccount {
    
    var addAccountModel: AddAccountModel?
    var completion: ((Result<AccountModel, DomainError>) -> Void)?
    
    func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
        self.addAccountModel = addAccountModel
        self.completion = completion
    }
    
    func completeWithError(_ error:DomainError){
        completion?(.failure(error))
    }
    
    func completeWithAccount(_ account: AccountModel){
        completion?(.success(account))
    }
}
