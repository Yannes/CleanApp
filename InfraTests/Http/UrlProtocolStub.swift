//
//  UrlProtocolStub.swift
//  InfraTests
//
//  Created by Yannes Meneguelli on 11/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation


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
