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

public func makeRemoteAddAccount(httpClient: HttpPostClient) -> AddAccount{
      let remoteAddAcoount =  RemoteAddAccount(url: makeApiUrl(path: "signup"), httpClient: httpClient)
      return MainQueueDispatchDecorator(remoteAddAcoount)
  }
