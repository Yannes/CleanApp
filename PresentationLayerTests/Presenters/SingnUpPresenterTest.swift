//
//  PresentationLayerTests.swift
//  PresentationLayerTests
//
//  Created by Yannes Meneguelli on 15/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import XCTest
import PresentationLayer

class SingnUpPresenterTest: XCTestCase {
    
    func test_signup_should_show_error_message_if_name_is_not_provider() throws {
        let alertViewspy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewspy)
        sut.signUp(viewModel: makesignUpViewModel(name: nil))
        XCTAssertEqual(alertViewspy.viewModel, AlertViewModel(title:"Falha na validação",message:"O Campo Nome é Obrigatorio"))
    }
    
    func test_signup_should_show_error_message_if_email_is_not_provider() throws {
        let alertViewspy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewspy)
        sut.signUp(viewModel: makesignUpViewModel(email: nil))
        XCTAssertEqual(alertViewspy.viewModel, AlertViewModel(title:"Falha na validação",message:"O Campo Email é Obrigatorio"))
    }
    
    
    func test_signup_should_show_error_message_if_password_is_not_provider() throws {
        let alertViewspy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewspy)
        sut.signUp(viewModel: makesignUpViewModel(password: nil))
        XCTAssertEqual(alertViewspy.viewModel, AlertViewModel(title:"Falha na validação",message:"O Campo Senha é Obrigatorio"))
    }
    
    func test_signup_should_show_error_message_if_confirmationpassword_is_not_provider() throws {
        let alertViewspy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewspy)
        sut.signUp(viewModel: makesignUpViewModel(passwordConfirm:nil))
        XCTAssertEqual(alertViewspy.viewModel, AlertViewModel(title:"Falha na validação",message:"O Campo Confirmar Senha é Obrigatorio"))
    }
    
    
    func test_signup_should_show_error_message_if_confirmationpassword_is_not_match() throws {
        let alertViewspy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewspy)
        sut.signUp(viewModel: makesignUpViewModel(passwordConfirm:"wrong_pass"))
        XCTAssertEqual(alertViewspy.viewModel, AlertViewModel(title:"Falha na validação",message:"Falha ao confirmar senha"))
    }
    
    
    
    func test_signup_should_call_emailValidator_with_correct_email() throws {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(emailValidator:emailValidatorSpy)
        let signupViewModel = makesignUpViewModel()
        sut.signUp(viewModel: signupViewModel)
        XCTAssertEqual(emailValidatorSpy.email, signupViewModel.email)
    }
    
    
    
    func test_signup_should_show_error_message_if_invalid_email_is_provider() throws {
        let alertViewspy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(alertView: alertViewspy,emailValidator: emailValidatorSpy)
        emailValidatorSpy.isvalid = false
        sut.signUp(viewModel: makesignUpViewModel())
        XCTAssertEqual(alertViewspy.viewModel, AlertViewModel(title:"Falha na validação",message:"Email invalido"))
    }
}


extension SingnUpPresenterTest{
    
    func makeSut(alertView: AlertViewSpy = AlertViewSpy() , emailValidator:EmailValidatorSpy = EmailValidatorSpy()) -> SignUpPresenter{
        let sut = SignUpPresenter(alertView: alertView, emailValidator: emailValidator)
        return (sut)
    }
    
    
    func makesignUpViewModel(name:String? = "any_name",email:String? = "any_email@email.com",password:String? = "any_pass",passwordConfirm:String? = "any_pass") -> SignUpViewModel{
        return SignUpViewModel(name: name, email: email, password: password, passwordConfirm: passwordConfirm)
    }
    
    
    class AlertViewSpy: AlertView {
        var viewModel: AlertViewModel?
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
        }
    }
    
     
    class EmailValidatorSpy: EmailValidator{
        var isvalid = true
        var email:String?
        
        func isValid(email:String) ->Bool{
            self.email = email
            return isvalid
        }
    }
    
}

