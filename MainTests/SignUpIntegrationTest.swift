//
//  SignUpIntegrationTest.swift
//  MainTests
//
//  Created by Yannes Meneguelli on 19/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import XCTest
import Main

class SignUpIntegrationTest: XCTestCase {
    
    
    func test_ui_presentatio_integrtion() throws {
        debugPrint("==========================================")
        debugPrint(Enviroment.variable(.apiBaseUrl))
        debugPrint("==========================================")
       let sut = SignUpComposer.composeControllerWith(addAccount:AddAccountSpy())
       checkMemoryLeak(for: sut)
    }
}
