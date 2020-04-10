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



class AlamofireAdapter: HttpPostClient {
    
    private let session: Session
    
    init (session: Session = .default){
        self.session = session
    }
    
    func post(to url: URL, with data: Data?,completion: @escaping(Result<Data?,HttpError>)-> Void){
        session.request(url,method: .post, parameters: data?.toJson(), encoding: JSONEncoding.default).responseData { dataResponse in
            guard  let statuscode = dataResponse.response?.statusCode else {return completion(.failure(.noConnectivity)) }
            switch dataResponse.result{
            case .failure: completion(.failure(.noConnectivity))
            case .success(let data):
                switch statuscode {
                case 204:
                    completion(.success(nil))
                case 200...299:
                    completion(.success(data))
                case 401:
                    completion(.failure(.unauthorized))
                case 403:
                    completion(.failure(.forbidden))
                case 400...499:
                    completion(.failure(.badRequest))
                case 500...599:
                    completion(.failure(.serverError))
                default:
                    completion(.failure(.noConnectivity))
                }
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
        expectResut(.failure(.noConnectivity), when: (data: nil, response:nil, error: makeError()))
    }
    
    
    func test_post_should_complete_with_error_on_all_invalid_cases() throws {
        expectResut(.failure(.noConnectivity), when: (data: makeValidData(), response:makeHttpResponse(), error: makeError()))
        expectResut(.failure(.noConnectivity), when: (data: makeValidData(), response:nil, error: makeError()))
        expectResut(.failure(.noConnectivity), when: (data: makeValidData(), response:nil, error: nil))
        expectResut(.failure(.noConnectivity), when: (data: nil, response:makeHttpResponse(), error: makeError()))
        expectResut(.failure(.noConnectivity), when: (data: nil, response:makeHttpResponse(), error: nil))
        expectResut(.failure(.noConnectivity), when: (data: nil, response:nil, error: nil))
    }
    
   
    func test_post_should_make_request_with_data_when_request_completes_with_200() throws {
        expectResut(.success(makeValidData()), when: (data: makeValidData(), response:makeHttpResponse(statusCode: 200), error: nil))
    }
    
    func test_post_should_make_request_with_no_data_when_request_completes_with_204() throws {
        expectResut(.success(nil), when: (data: nil, response:makeHttpResponse(statusCode: 204), error: nil))
        expectResut(.success(nil), when: (data: makeEmptyData(), response:makeHttpResponse(statusCode: 204), error: nil))
        expectResut(.success(nil), when: (data: makeValidData(), response:makeHttpResponse(statusCode: 204), error: nil))
    }
    
    func test_post_should_make_request_with_data_when_request_completes_with_non_200() throws {
        
        expectResut(.failure(.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 400), error: nil))
        expectResut(.failure(.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 450), error: nil))
        expectResut(.failure(.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 499), error: nil))
        expectResut(.failure(.serverError), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 500), error: nil))
        expectResut(.failure(.serverError), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 550), error: nil))
        expectResut(.failure(.serverError), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 599), error: nil))
        expectResut(.failure(.unauthorized), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 401), error: nil))
        expectResut(.failure(.forbidden), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 403), error: nil))
        expectResut(.failure(.noConnectivity), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 300), error: nil))
        expectResut(.failure(.noConnectivity), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 100), error: nil))
        
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
        let exp = expectation(description: "Waiting ")
        sut.post(to: url, with: data) {_ in exp.fulfill()}
        var request: URLRequest?
        UrlProtocolStub.observerRequest { request = $0}
        wait(for: [exp], timeout: 1)
        action(request!)
    }
    
    
    func expectResut(_ expectedREsult: Result<Data?,HttpError>, when stub: (data: Data?, response: HTTPURLResponse?, error: Error?),file: StaticString = #file, line: UInt = #line){
        let sut = makeSut()
        UrlProtocolStub.simulate(data: stub.data  , response: stub.response, error: stub.error)
        let exp = expectation(description: "Waiting ")
        sut.post(to: makeUrl(), with: makeValidData()){ receivedResult in
            switch (expectedREsult, receivedResult){
            case (.failure(let expecteError), .failure(let receiveError)): XCTAssertEqual(expecteError, receiveError,file: file, line: line)
            case (.success(let expectedData),.success(let receivedData)): XCTAssertEqual(expectedData, receivedData,file: file, line: line)
            default: XCTFail("Expected  \(expectedREsult) got \(receivedResult)instead",file: file, line: line)
                
            }
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
