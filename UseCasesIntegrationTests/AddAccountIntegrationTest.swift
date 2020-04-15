//
//  UseCasesIntegrationTests.swift
//  UseCasesIntegrationTests
//
//  Created by Yannes Meneguelli on 15/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import XCTest
import Data
import Infra
import Domain

class UseCasesIntegrationTests: XCTestCase {

    func test_add_account() throws {
        let alamofireAdapter = AlamofireAdapter()
        let url = URL(string: "https://clean-node-api.herokuapp.com/api/signup")!
        let sut = RemoteAddAccount(url: url, httpClient: alamofireAdapter)
        let addAccountModel = AddAccountModel(name: "Yannes Meneguelli", email: "yannes_meneguelli@hotmail.com", password: "secret", passwordConfirmation: "secret")
        
        let exp = expectation(description: "Waiting")
        
        sut.add(addAccountModel: addAccountModel) { result in
            switch result{
            case .failure: XCTFail("Expected sucess got \(result) instead")
            case .success(let account):
                XCTAssertNotNil(account.id)
                XCTAssertEqual(account.name, addAccountModel.name)
                XCTAssertEqual(account.email, addAccountModel.email)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }

}
