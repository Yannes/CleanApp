//
//  UseCaseFactory.swift
//  Main
//
//  Created by Yannes Meneguelli on 19/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//


import Foundation
import Data
import Domain
import Infra


final class UseCaseFactory {
    
    
    private static let httpClient = AlamofireAdapter()
    private static let apiBaseUrl = Enviroment.variable(.apiBaseUrl)
    
    
    private static func makeUrl(path:String) -> URL{
        return URL(string: "\(apiBaseUrl)/\(path)")!
    }
    
    
    
    public static func makeRemoteAddAccount() -> AddAccount{
        let remoteAddAcoount =  RemoteAddAccount(url: makeUrl(path: "signup"), httpClient: httpClient)
        return MainQueueDispatchDecorator(remoteAddAcoount)
    }
}

