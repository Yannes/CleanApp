//
//  DataTests.swift
//  DataTests
//
//  Created by Yannes Meneguelli on 08/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import XCTest
import Domain
import Data





class RemoteAddAccountTest: XCTestCase {
    
    func test_add_should_call_httpClient_correct_url() {
        let url =  URL(string: "https://any-url.com")!
        let (sut,httpClientSpy) = makeSut(url: url)
        sut.add(addAccountModel: makeAddAccountModel())
        XCTAssertEqual(httpClientSpy.urls, [url])
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
        
        var urls = [URL]()
        var data:Data?
        
        
        func post(to url: URL, with data: Data?) {
            self.urls.append(url)
            self.data = data

        }
    }
}
