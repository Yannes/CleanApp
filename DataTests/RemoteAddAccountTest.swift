//
//  DataTests.swift
//  DataTests
//
//  Created by Yannes Meneguelli on 08/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import XCTest


class RemoteAddAccount{
    
    private let url: URL
    private let httpclient: HttpPostClient
    
    
    
    init(url:URL ,httpClient: HttpPostClient) {
        self.url = url
        self.httpclient = httpClient
    }
    
    func add() {
        httpclient.post(url: url)
    }
}

protocol HttpPostClient {
    func post(url:URL)
}





class RemoteAddAccountTest: XCTestCase {
    
    func test_add_should_call_httpClient_correct_url() {
        let url =  URL(string: "https://any-url.com")!
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url:url, httpClient: httpClientSpy)
        sut.add()
        XCTAssertEqual(httpClientSpy.url, url)
        
    }
    
    
    
    class HttpClientSpy: HttpPostClient {
        
        var url:URL?
        
        func post(url:URL){
            self.url = url
        }
    }
}
