//
//  TestFactorys.swift
//  DataTests
//
//  Created by Yannes Meneguelli on 09/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation


func makeUrl() -> URL{
    return URL(string: "https://any-url.com")!
}

func makeInvalidData() -> Data{
    return Data("invalid_data".utf8)
}
