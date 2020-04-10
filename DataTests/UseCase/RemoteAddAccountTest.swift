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
        sut.add(addAccountModel: makeAddAccountModel()) {_ in }
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    func test_add_should_call_httpClient_correct_data() {
        let (sut,httpClientSpy) = makeSut()
        let addAccountModel = makeAddAccountModel()
        sut.add(addAccountModel: addAccountModel) {_ in }
        XCTAssertEqual(httpClientSpy.data, addAccountModel.toData())
    }
    
    
    func test_add_should_complete_with_error_if_client_Completes_with_error() {
        let (sut,httpClientSpy) = makeSut()
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel: makeAddAccountModel()) { result in
            
            switch result {
              case .failure(let error): XCTAssertEqual(error, .unexpected)
              case .success: XCTFail("Expected error receive \(result)")
            }
            exp.fulfill()
        }
        httpClientSpy.completeWithError(.noConnectivity)
        wait(for: [exp], timeout: 1)
    }
    
    
    func test_add_should_complete_with_account_if_client_Completes_with_data() {
        let (sut,httpClientSpy) = makeSut()
        let exp = expectation(description: "waiting")
        let expectedAccount = makeAccountModel()
        sut.add(addAccountModel: makeAddAccountModel()) { result in
            
            switch result {
            case .failure:XCTFail("Expected sucess received \(result) instead")
            case .success(let receivedAccount): XCTAssertEqual(receivedAccount, expectedAccount)
            }
            exp.fulfill()
        }
        httpClientSpy.completeWithData(expectedAccount.toData()!)
        wait(for: [exp], timeout: 1)
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
    
    func makeAccountModel() -> AccountModel{
        return AccountModel(id: "any_account", name: "Any_name", email: "any_email@hotmail.com", password: "any_password")
     }
    
    
    
    class HttpClientSpy: HttpPostClient {
        
        var urls = [URL]()
        var data:Data?
        var completion: ((Result<Data, HttpError>) -> Void)?
        
        
        func post(to url: URL, with data: Data?, completion: @escaping(Result<Data, HttpError>) -> Void) {
            self.urls.append(url)
            self.data = data
            self.completion = completion
        }
        
        func completeWithError(_ error: HttpError){
            completion?(.failure(error))
        }
        
        
        func completeWithData(_ data: Data){
            completion?(.success(data))
        }
        
    }
}
