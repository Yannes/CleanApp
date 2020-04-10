//
//  InfraTests.swift
//  InfraTests
//
//  Created by Yannes Meneguelli on 10/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import XCTest
import Alamofire



class AlamofireAdapter {
    
    private let session: Session
    
    init (session: Session = .default){
        self.session = session
    }
    
    func post(to url: URL, with data: Data?){
        
        let json =  data == nil ? nil : try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:Any]
        session.request(url,method: .post, parameters: json, encoding: JSONEncoding.default ).resume()
    }
}




class AlamofireAdapterTest: XCTestCase {


    func test_post_should_make_request_with_valid_url_and_method() throws {
        let url = makeUrl()
        let sut = makeSut()
        sut.post(to: url, with: makeValidData())
        let exp = expectation(description: "Waiting ")
        UrlProtocolStub.observerRequest { request in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("POST", request.httpMethod)
            XCTAssertNotNil(request.httpBodyStream)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
    
    
    
    
    func test_post_should_make_request_with_no_data() throws {
        let sut = makeSut()
        sut.post(to: makeUrl(), with: nil)
        let exp = expectation(description: "Waiting ")
        UrlProtocolStub.observerRequest { request in
            XCTAssertNil(request.httpBodyStream)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}


extension AlamofireAdapterTest{
    func makeSut() -> AlamofireAdapter{
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        let session = Session(configuration:configuration)
        return AlamofireAdapter(session: session)
    }
}



class UrlProtocolStub: URLProtocol{
    
    static var enit: ((URLRequest) -> Void)?
    
    static func observerRequest(completion: @escaping (URLRequest) -> Void){
        UrlProtocolStub.enit = completion
    }
    
    override open class  func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    
    override open func startLoading() {
        UrlProtocolStub.enit?(request)
    }
    
    open override func stopLoading() {
        
    }
    
    
    
}
