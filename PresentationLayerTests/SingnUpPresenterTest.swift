//
//  PresentationLayerTests.swift
//  PresentationLayerTests
//
//  Created by Yannes Meneguelli on 15/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import XCTest





class SignUpPresenter {
    
    
    private let alertView:AlertView
    
    
    init(alertView: AlertView) {
        self.alertView = alertView
    }
    
    
    func signUp(viewModel: SignUpViewModel){
        if let message = validate(viewModel: viewModel){
           alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        }
    }
        
    
    private func validate(viewModel: SignUpViewModel) -> String?{
        if viewModel.name == nil ||  viewModel.name!.isEmpty {
            return "O Campo Nome é Obrigatorio"
        }
        
        if viewModel.email == nil ||  viewModel.email!.isEmpty {
            return "O Campo Email é Obrigatorio"
        }
        
        if viewModel.password == nil ||  viewModel.password!.isEmpty {
            return "O Campo Senha é Obrigatorio"
        }
        
        
        if viewModel.passwordConfirmation == nil ||  viewModel.passwordConfirmation!.isEmpty {
            return "O Campo Confirmar Senha é Obrigatorio"
        }
        return nil
    }
    
    
    
}

protocol AlertView {
    func showMessage(viewModel:  AlertViewModel)
}


struct  AlertViewModel:Equatable {
    var title: String
    var message:String
}


struct SignUpViewModel{
    var name: String?
    var email: String?
    var password: String?
    var passwordConfirmation: String?
}



class SingnUpPresenterTest: XCTestCase {

    func test_signup_should_show_error_message_if_name_is_not_provider() throws {
        let (sut,alertViewSpy) = makeSut()
        let signupViewModel = SignUpViewModel(email: "any_email@email.com", password: "any_pass", passwordConfirmation: "any_pass")
        sut.signUp(viewModel: signupViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title:"Falha na validação",message:"O Campo Nome é Obrigatorio"))
    }
    
    func test_signup_should_show_error_message_if_email_is_not_provider() throws {
        let (sut,alertViewSpy) = makeSut()
        let signupViewModel = SignUpViewModel(name: "any_name", password: "any_pass", passwordConfirmation: "any_pass")
        sut.signUp(viewModel: signupViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title:"Falha na validação",message:"O Campo Email é Obrigatorio"))
    }
    
    
    func test_signup_should_show_error_message_if_password_is_not_provider() throws {
          let (sut,alertViewSpy) = makeSut()
          let signupViewModel = SignUpViewModel(name: "any_name", email: "any_email@email.com", passwordConfirmation: "any_pass")
          sut.signUp(viewModel: signupViewModel)
          XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title:"Falha na validação",message:"O Campo Senha é Obrigatorio"))
      }
    
    func test_signup_should_show_error_message_if_confirmationpassword_is_not_provider() throws {
        let (sut,alertViewSpy) = makeSut()
        let signupViewModel = SignUpViewModel(name: "any_name", email: "any_email@email.com", password: "any_pass")
        sut.signUp(viewModel: signupViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title:"Falha na validação",message:"O Campo Confirmar Senha é Obrigatorio"))
    }
}


extension SingnUpPresenterTest{
    
    func makeSut() ->(sut: SignUpPresenter, alertViewSpy: AlertViewSpy){
        let alertViewSpy = AlertViewSpy()
        let sut = SignUpPresenter(alertView: alertViewSpy)
        return (sut,alertViewSpy)
    }
    
    
    
    
    
    
    class AlertViewSpy: AlertView {
        var viewModel: AlertViewModel?
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
        }
    }
    
}

