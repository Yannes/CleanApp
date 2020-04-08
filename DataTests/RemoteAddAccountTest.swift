//
//  DataTests.swift
//  DataTests
//
//  Created by Yannes Meneguelli on 08/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import XCTest
import Domain


class RemoteAddAccount{
    
    private let url: URL
    private let httpclient: HttpPostClient
    
    
    
    init(url:URL ,httpClient: HttpPostClient) {
        self.url = url
        self.httpclient = httpClient
    }
    
    func add(addAccountModel: AddAccountModel) {
        
        httpclient.post(to: url, with: addAccountModel.toData())
    }
}

protocol HttpPostClient {
    func post(to url:URL, with data:Data?)
}





class RemoteAddAccountTest: XCTestCase {
    
    func test_add_should_call_httpClient_correct_url() {
        let url =  URL(string: "https://any-url.com")!
        let (sut,httpClientSpy) = makeSut(url: url)
        sut.add(addAccountModel: makeAddAccountModel())
        XCTAssertEqual(httpClientSpy.url, url)
    }
    
    func test_add_should_call_httpClient_correct_data() {
        let (sut,httpClientSpy) = makeSut()
        let addAccountModel = makeAddAccountModel()
        sut.add(addAccountModel: addAccountModel)
        XCTAssertEqual(httpClientSpy.data, addAccountModel.toData())
    }
}

extension RemoteAddAccountTest{
    
    func makeSut(url:URL = URL(string: "https://any-url.com")!) -> (sut:RemoteAddAccount, httpClientSpy: HttpClientSpy){
        let httpClientSpy = HttpClientSpy()
        let sut =  RemoteAddAccount(url:url, httpClient: httpClientSpy)
        return (sut, httpClientSpy)
    }
    
    
    func makeAddAccountModel() -> AddAccountModel{
        return AddAccountModel(name: "Any_name", email: "any_email@hotmail.com", password: "any_password", passwordConfirmation: "any_password")
    }
    
    
    
    
    class HttpClientSpy: HttpPostClient {
        
        var url:URL?
        var data:Data?
        
        func post(to url: URL, with data: Data?) {
            self.url = url
            self.data = data
        }
    }
}
