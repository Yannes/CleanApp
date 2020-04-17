//
//  PresentationLayerTests.swift
//  PresentationLayerTests
//
//  Created by Yannes Meneguelli on 15/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import XCTest
import PresentationLayer
import Domain

class SingnUpPresenterTest: XCTestCase {
    
    func test_signup_should_show_error_message_if_name_is_not_provider() throws {
        let alertViewspy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewspy)
        let exp = expectation(description: "Waiting")
        alertViewspy.observe { viewModel in
            XCTAssertEqual(viewModel,makeRequiredAlertViewModel(fieldName: "Nome"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makesignUpViewModel(name: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signup_should_show_error_message_if_email_is_not_provider() throws {
        let alertViewspy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewspy)
        let exp = expectation(description: "Waiting")
        alertViewspy.observe { viewModel in
            XCTAssertEqual(viewModel,makeRequiredAlertViewModel(fieldName: "Email"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makesignUpViewModel(email: nil))
        wait(for: [exp], timeout: 1)
    }
    
    
    func test_signup_should_show_error_message_if_password_is_not_provider() throws {
        let alertViewspy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewspy)
        let exp = expectation(description: "Waiting")
        alertViewspy.observe { viewModel in
            XCTAssertEqual(viewModel, makeRequiredAlertViewModel(fieldName: "Senha"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makesignUpViewModel(password: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signup_should_show_error_message_if_confirmationpassword_is_not_provider() throws {
        let alertViewspy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewspy)
        let exp = expectation(description: "Waiting")
        alertViewspy.observe { viewModel in
            XCTAssertEqual(viewModel, makeRequiredAlertViewModel(fieldName: "Confirmar Senha"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makesignUpViewModel(passwordConfirm:nil))
        wait(for: [exp], timeout: 1)
    }
    
    
    func test_signup_should_show_error_message_if_confirmationpassword_is_not_match() throws {
        let alertViewspy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewspy)
        let exp = expectation(description: "Waiting")
        alertViewspy.observe {viewModel in
            XCTAssertEqual(viewModel,makeInvalidAlertViewModel(fieldName: "Confirmar Senha"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makesignUpViewModel(passwordConfirm:"wrong_pass"))
        wait(for: [exp], timeout: 1)
    }
    
    
    
    func test_signup_should_show_error_message_if_invalid_email_is_provider() throws {
        let alertViewspy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(alertView: alertViewspy,emailValidator: emailValidatorSpy)
        let exp = expectation(description: "Waiting")
        alertViewspy.observe { viewModel in
            XCTAssertEqual(viewModel, makeInvalidAlertViewModel(fieldName: "Email"))
            exp.fulfill()
        }
        emailValidatorSpy.simulateInvalidEmail()
        sut.signUp(viewModel: makesignUpViewModel())
        wait(for: [exp], timeout: 1)
    }
    
    
    func test_signup_should_call_emailValidator_with_correct_email() throws {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(emailValidator:emailValidatorSpy)
        let signupViewModel = makesignUpViewModel()
        sut.signUp(viewModel: signupViewModel)
        XCTAssertEqual(emailValidatorSpy.email, signupViewModel.email)
    }
    
    
    func test_signup_should_call_addaccount_with_correct_values() throws {
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount:addAccountSpy)
        sut.signUp(viewModel: makesignUpViewModel())
        XCTAssertEqual(addAccountSpy.addAccountModel, makeAddAccountModel() )
    }
    
    
    func test_signup_should_show_error_message_if_addAccount_fails() throws {
        let alertViewspy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertView: alertViewspy,addAccount: addAccountSpy)
        let exp = expectation(description: "Waiting")
        alertViewspy.observe {viewModel in
            XCTAssertEqual(viewModel,makeErrorAlertViewModel(message: "Algo de inesperado aconteceu tente novamente em alguns instantes"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makesignUpViewModel())
        addAccountSpy.completeWithError(.unexpected)
        wait(for: [exp], timeout: 1)
        
    }
    
    func test_signup_should_show_loading_before_and_after_add_account() throws {
        let loadViewSpy = LoadingViewSpy()
         let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount: addAccountSpy, loadingView: loadViewSpy)
        let exp = expectation(description: "Waiting")
        loadViewSpy.observe {viewModel in
            XCTAssertEqual(viewModel,LoadingViewModel(isLoading: true))
            exp.fulfill()
        }
        sut.signUp(viewModel: makesignUpViewModel())
        wait(for: [exp], timeout: 1)
        let exp2 = expectation(description: "Waiting")
        loadViewSpy.observe {viewModel in
            XCTAssertEqual(viewModel,LoadingViewModel(isLoading: false))
            exp2.fulfill()
        }
        addAccountSpy.completeWithError(.unexpected)
        wait(for: [exp2], timeout: 1)
    }
    
    
    func test_signup_should_show_error_message_if_addAccount_succeeds() throws {
          let alertViewspy = AlertViewSpy()
          let addAccountSpy = AddAccountSpy()
          let sut = makeSut(alertView: alertViewspy,addAccount: addAccountSpy)
          let exp = expectation(description: "Waiting")
          alertViewspy.observe {viewModel in
            XCTAssertEqual(viewModel,makeSuccessAlertViewModel(message: "Conta criada com sucesso."))
              exp.fulfill()
          }
          sut.signUp(viewModel: makesignUpViewModel())
        addAccountSpy.completeWithAccount(makeAccountModel())
          wait(for: [exp], timeout: 1)
          
      }
    
    

    func checkMemoryLeak2(for instance: AnyObject, file: StaticString = #file, line: UInt = #line){
        addTeardownBlock {[weak instance ] in
            XCTAssertNil(instance,file: file , line: line)
        }
    }
}


extension SingnUpPresenterTest{
    
    func makeSut(alertView: AlertViewSpy = AlertViewSpy() , emailValidator:EmailValidatorSpy = EmailValidatorSpy(),addAccount: AddAccountSpy = AddAccountSpy(),loadingView: LoadingViewSpy = LoadingViewSpy(),file: StaticString = #file, line: UInt = #line) -> SignUpPresenter{
        let sut = SignUpPresenter(alertView: alertView, emailValidator: emailValidator, addAccount: addAccount, loadingView: loadingView)
        checkMemoryLeak2(for: sut,file: file , line: line)
        return (sut)
    }
    
}
