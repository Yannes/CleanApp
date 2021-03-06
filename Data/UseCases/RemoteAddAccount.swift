//
//  RemoteAddAccount.swift
//  Data
//  Created by Yannes Meneguelli on 08/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation
import Domain

public final class RemoteAddAccount: AddAccount{

    
    
    private let url: URL
    private let httpclient: HttpPostClient
    
    
    
  public   init(url:URL ,httpClient: HttpPostClient) {
        self.url = url
        self.httpclient = httpClient
    }
    
    public  func add(addAccountModel: AddAccountModel, completion:@escaping (Result<AccountModel,DomainError>) -> Void) {
        httpclient.post(to: url, with: addAccountModel.toData()) { [weak self]result in
            guard self != nil else {return}
            switch result {
            case.success(let data):
                if  let model: AccountModel  =  data?.toModel(){
                    completion(.success(model))
                }else {
                    completion(.failure(.unexpected))
                }
            case.failure(let error):
                switch error {
                case .forbidden:
                     completion(.failure(.emailInuse))
                default:
                     completion(.failure(.unexpected))
                }
            }
        }
    }
}
