//
//  InfraTests.swift
//  InfraTests
//
//  Created by Yannes Meneguelli on 10/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import XCTest
import Alamofire
import Data



class AlamofireAdapter {
    
    private let session: Session
    
    init (session: Session = .default){
        self.session = session
    }
    
    func post(to url: URL, with data: Data?,completion: @escaping(Result<Data,HttpError>)-> Void){
        session.request(url,method: .post, parameters: data?.toJson(), encoding: JSONEncoding.default).responseData { dataResponse in
            switch dataResponse.result{
            case .failure: completion(.failure(.noConnectivity))
            case .success: break
            }
        }
    }
}




class AlamofireAdapterTest: XCTestCase {


    func test_post_should_make_request_with_valid_url_and_method() throws {
        let url = makeUrl()
        testRequestFor(url: url, data: makeValidData()) { request in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("POST", request.httpMethod)
            XCTAssertNotNil(request.httpBodyStream)
        }
    }
    
    func test_post_should_make_request_with_no_data() throws {
        testRequestFor(data: nil) { request in
             XCTAssertNil(request.httpBodyStream)
        }
    }
    
    
    
    func test_post_should_make_request_with_error_when_request_completes_with_error() throws {
           
        let sut = makeSut()
        UrlProtocolStub.simulate(data: nil, response: nil, error: makeError())
        let exp = expectation(description: "Waiting ")
        sut.post(to: makeUrl(), with: makeValidData()){ result in
            switch result{
            case .success: XCTFail("Expected error \(result) instead")
            case .failure(let error): XCTAssertEqual(error, .noConnectivity)
            }
            exp.fulfill()
         }
        wait(for: [exp], timeout: 1)
       }
 
}


extension AlamofireAdapterTest{
    
    func makeSut(file: StaticString = #file, line: UInt = #line) -> AlamofireAdapter{
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        let session = Session(configuration:configuration)
        let sut = AlamofireAdapter(session: session)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
    
    func testRequestFor(url:URL = makeUrl(), data:Data?, action: @escaping(URLRequest) -> Void){
        let sut = makeSut()
        sut.post(to: url, with: data) {_ in}
        let exp = expectation(description: "Waiting ")
        UrlProtocolStub.observerRequest { request in
            action(request)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}



class UrlProtocolStub: URLProtocol{
    
    static var enit: ((URLRequest) -> Void)?
    
    static var data: Data?
    static var response: HTTPURLResponse?
    static var error: Error?
    
    
    static func observerRequest(completion: @escaping (URLRequest) -> Void){
        UrlProtocolStub.enit = completion
    }
    
    
    static func simulate(data:Data?, response:HTTPURLResponse?, error:Error?){
        UrlProtocolStub.data = data
        UrlProtocolStub.response = response
        UrlProtocolStub.error = error
    }
    
    
    override open class  func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    
    override open func startLoading() {
        UrlProtocolStub.enit?(request)
        
        if let data = UrlProtocolStub.data{
            client?.urlProtocol(self, didLoad: data)
        }
        
        if let response = UrlProtocolStub.response{
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        
        if let error = UrlProtocolStub.error{
            client?.urlProtocol(self, didFailWithError: error)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    open override func stopLoading() {
        
    }
}
