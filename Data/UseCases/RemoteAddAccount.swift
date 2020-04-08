//
//  RemoteAddAccount.swift
//  Data
//
//  Created by Yannes Meneguelli on 08/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation
import Domain

public final class RemoteAddAccount{
    
    private let url: URL
    private let httpclient: HttpPostClient
    
    
    
  public   init(url:URL ,httpClient: HttpPostClient) {
        self.url = url
        self.httpclient = httpClient
    }
    
  public  func add(addAccountModel: AddAccountModel) {
      httpclient.post(to: url, with: addAccountModel.toData())
    }
}
