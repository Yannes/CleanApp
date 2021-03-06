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
    
    
    func test_saveButton_calls_signUp_on_tap() throws {
        var singUpViewModel = SignUpViewModel()
        let sut = makeSut(signUpSpy: {singUpViewModel = $0})
        sut.saveButton?.simulateTap()
        let name = sut.nameTextField?.text
        let email = sut.emailTExtField?.text
        let senha = sut.senhaTextField?.text
        let confirmarSenha = sut.confirmarSenhaTextField?.text
        XCTAssertEqual(singUpViewModel, SignUpViewModel(name: name, email: email, password: senha , passwordConfirm: confirmarSenha))
    }
}




extension SignUpViewControllerTests{
    func makeSut(signUpSpy:((SignUpViewModel) -> Void)? = nil) -> SignUpViewController{
        let sut = SignUpViewController.instantiate()
        sut.signUp =  signUpSpy
        sut.loadViewIfNeeded()
        return sut
    }
}


