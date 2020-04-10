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
    
    func post(to url: URL){
        session.request(url).resume()
    }
}




class AlamofireAdapterTest: XCTestCase {


    func test_() throws {
        let url = makeUrl()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        let session = Session(configuration:configuration)
        let sut = AlamofireAdapter(session: session)
        sut.post(to: url)
        let exp = expectation(description: "Waiting ")
        UrlProtocolStub.observerRequest { request in
            XCTAssertEqual(url, request.url)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
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
