//
//  AccountModel.swift
//  Domain
//
//  Created by Yannes Meneguelli on 08/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation


public struct AccountModel:Model {
    public  var accessToken: String

    public init(accessToken:String){
        self.accessToken = accessToken
    }
}
