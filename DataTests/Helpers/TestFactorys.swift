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


func makeValidData() -> Data{
    return Data("{\"name\":\"Yannes\"}".utf8)
}


func makeEmptyData() -> Data{
    return Data()
}




func makeInvalidData() -> Data{
    return Data("invalid_data".utf8)
}


func makeError() -> Error{
    return NSError(domain: "any_error", code: 0)
}



func makeHttpResponse(statusCode:Int = 200) -> HTTPURLResponse{
    return HTTPURLResponse(url: makeUrl(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}

