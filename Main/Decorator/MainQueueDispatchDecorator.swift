//
//  MainQueueDispatchDecorator.swift
//  Main
//
//  Created by Yannes Meneguelli on 20/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation
import Data
import Domain
import Infra


public final class MainQueueDispatchDecorator<T>{
    
    private let instance:T
    
    public init(_ instance:T) {
        self.instance = instance
    }
    
    func dispatch(completion: @escaping() -> Void){
        guard Thread.isMainThread else {return DispatchQueue.main.async(execute: completion)}
        completion()
    }
}


extension MainQueueDispatchDecorator:AddAccount where T: AddAccount{
    public func add(addAccountModel: AddAccountModel, completion: @escaping (AddAccount.Result) -> Void) {
        instance.add(addAccountModel: addAccountModel) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}
