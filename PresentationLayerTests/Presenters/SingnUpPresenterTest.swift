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
        sut.signUp(viewModel: makesignUpViewModel(name: nil))
        XCTAssertEqual(alertViewspy.viewModel, makeRequiredAlertViewModel(fieldName: "Nome"))
    }
    
    func test_signup_should_show_error_message_if_email_is_not_provider() throws {
        let alertViewspy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewspy)
        sut.signUp(viewModel: makesignUpViewModel(email: nil))
        XCTAssertEqual(alertViewspy.viewModel, makeRequiredAlertViewModel(fieldName: "Email"))
    }
    
    
    func test_signup_should_show_error_message_if_password_is_not_provider() throws {
        let alertViewspy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewspy)
        sut.signUp(viewModel: makesignUpViewModel(password: nil))
        XCTAssertEqual(alertViewspy.viewModel, makeRequiredAlertViewModel(fieldName: "Senha"))
    }
    
    func test_signup_should_show_error_message_if_confirmationpassword_is_not_provider() throws {
        let alertViewspy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewspy)
        sut.signUp(viewModel: makesignUpViewModel(passwordConfirm:nil))
        XCTAssertEqual(alertViewspy.viewModel, makeRequiredAlertViewModel(fieldName: "Confirmar Senha"))
    }
    
    
    func test_signup_should_show_error_message_if_confirmationpassword_is_not_match() throws {
        let alertViewspy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewspy)
        sut.signUp(viewModel: makesignUpViewModel(passwordConfirm:"wrong_pass"))
        XCTAssertEqual(alertViewspy.viewModel, makeInvalidAlertViewModel(fieldName: "Confirmar Senha"))
    }
    
    
    
    func test_signup_should_show_error_message_if_invalid_email_is_provider() throws {
           let alertViewspy = AlertViewSpy()
           let emailValidatorSpy = EmailValidatorSpy()
           let sut = makeSut(alertView: alertViewspy,emailValidator: emailValidatorSpy)
           emailValidatorSpy.simulateInvalidEmail()
           sut.signUp(viewModel: makesignUpViewModel())
           XCTAssertEqual(alertViewspy.viewModel, makeInvalidAlertViewModel(fieldName: "Email"))
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
              sut.signUp(viewModel: makesignUpViewModel())
              addAccountSpy.completeWithError(.unexpected)
              XCTAssertEqual(alertViewspy.viewModel,makeErrorAlertViewModel(message: "Algo de inesperado aconteceu tente novamente em alguns instantes"))
          }
    
    
    
    

}


extension SingnUpPresenterTest{
    
    func makeSut(alertView: AlertViewSpy = AlertViewSpy() , emailValidator:EmailValidatorSpy = EmailValidatorSpy(),addAccount: AddAccountSpy = AddAccountSpy()) -> SignUpPresenter{
        let sut = SignUpPresenter(alertView: alertView, emailValidator: emailValidator, addAccount: addAccount)
        return (sut)
    }
    
    
    func makesignUpViewModel(name:String? = "any_name",email:String? = "any_email@email.com",password:String? = "any_pass",passwordConfirm:String? = "any_pass") -> SignUpViewModel{
        return SignUpViewModel(name: name, email: email, password: password, passwordConfirm: passwordConfirm)
    }
    
    
    
    func makeRequiredAlertViewModel(fieldName:String) ->AlertViewModel{
        return AlertViewModel(title:"Falha na validação",message:"O Campo \(fieldName) é Obrigatorio")
    }
    
    func makeInvalidAlertViewModel(fieldName:String) ->AlertViewModel{
        return AlertViewModel(title:"Falha na validação",message:"O Campo \(fieldName) é invalido")
    }
    
    public func makeAddAccountModel() -> AddAccountModel{
        return AddAccountModel(name: "any_name", email: "any_email@email.com", password: "any_pass", passwordConfirmation: "any_pass")
    }
     
    
    func makeErrorAlertViewModel(message:String) ->AlertViewModel{
        return AlertViewModel(title:"Erro",message: message)
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
        
        func simulateInvalidEmail(){
            isvalid = false
        }
        
        
        
    }
    
}



class AddAccountSpy: AddAccount {
    
    var addAccountModel: AddAccountModel?
    var completion: ((Result<AccountModel, DomainError>) -> Void)?
    
    func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
        self.addAccountModel = addAccountModel
        self.completion = completion
    }
    
    
    func completeWithError(_ error:DomainError){
        completion?(.failure(error))
    }
    
}
