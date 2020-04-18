//
//  UITests.swift
//  UITests
//
//  Created by Yannes Meneguelli on 17/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import XCTest
import UIKit
@testable import UI
import PresentationLayer


class SignUpViewControllerTests: XCTestCase {
    
    
    func test_loading_is_hidden_on_start() throws {
        XCTAssertEqual(makeSut().loadingIndicator?.isAnimating, false)
    }
    
    func test_sut_implements_lodingView() throws {
        XCTAssertNotNil(makeSut() as LoadingView)
    }
    
    
    func test_sut_implements_alertView() throws {
        XCTAssertNotNil(makeSut() as AlertView)
    }
}




extension SignUpViewControllerTests{
    func makeSut() -> SignUpViewController{
        let sb = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
        let sut = sb.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        sut.loadViewIfNeeded()
        return sut
    }
}
