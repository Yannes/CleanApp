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
    
  
    
    func test_signup_should_call_addaccount_with_correct_values() throws {
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount:addAccountSpy)
        sut.signUp(viewModel: makesignUpViewModel())
        XCTAssertEqual(addAccountSpy.addAccountModel,  makeAddAccountModel())
    }
    

    func test_signup_should_show_error_message_if_addAccount_fails() throws {
        let alertViewspy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertView: alertViewspy,addAccount: addAccountSpy)
        let exp = expectation(description: "Waiting")
        alertViewspy.observe {viewModel in
            XCTAssertEqual(viewModel,AlertViewModel(title: "Erro", message: "Algo de inesperado aconteceu tente novamente em alguns instantes"))
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
            XCTAssertEqual(viewModel,AlertViewModel(title:"Sucesso",message: "Conta criada com sucesso."))
              exp.fulfill()
          }
          sut.signUp(viewModel: makesignUpViewModel())
        addAccountSpy.completeWithAccount(makeAccountModel())
          wait(for: [exp], timeout: 1)
          
      }
    
    
    func test_singup_should_call_validation_with_corrrext_values(){
        let validationSpy = ValidationSpy()
        let sut = makeSut(validation: validationSpy)
        let viewModel = makesignUpViewModel()
        sut.signUp(viewModel: viewModel)
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to:viewModel.toJson()!))
    }
    
    
    func test_signup_should_show_error_message_if_validation_fails() throws {
        let alertViewspy = AlertViewSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(alertView: alertViewspy,validation: validationSpy)
        let exp = expectation(description: "Waiting")
        alertViewspy.observe { viewModel in
            XCTAssertEqual(viewModel,AlertViewModel(title:"Falha na validação",message:"Erro"))
            exp.fulfill()
        }
        validationSpy.simulateError()
        sut.signUp(viewModel: makesignUpViewModel())
        wait(for: [exp], timeout: 1)
    }
}


extension SingnUpPresenterTest{
    
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(),addAccount: AddAccountSpy = AddAccountSpy(),loadingView: LoadingViewSpy = LoadingViewSpy(),validation:Validation = ValidationSpy(),file: StaticString = #file, line: UInt = #line) -> SignUpPresenter{
        let sut = SignUpPresenter(alertView: alertView, addAccount: addAccount, loadingView: loadingView,validation: validation)
        checkMemoryLeak(for: sut,file: file , line: line)
        return (sut)
    }
    
    
    
    func makeAccountModel() -> AccountModel{
       return AccountModel(accessToken: "any_token")
    }
    
     func makeAddAccountModel() -> AddAccountModel{
        return AddAccountModel(name: "any_name", email: "any_email@email.com", password: "any_pass", passwordConfirmation: "any_pass")
    }
}


