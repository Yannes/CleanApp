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
        if viewModel.name == nil ||  viewModel.name!.isEmpty {
           alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: "O Campo Nome é Obrigatorio"))
        }
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
        let alertViewSpy = AlertViewSpy()
        let sut = SignUpPresenter(alertView: alertViewSpy)
        let signupViewModel = SignUpViewModel(email: "any_email@email.com", password: "any_pass", passwordConfirmation: "any_pass")
        sut.signUp(viewModel: signupViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title:"Falha na validação",message:"O Campo Nome é Obrigatorio"))
    }
}


extension SingnUpPresenterTest{
    
    class AlertViewSpy: AlertView {
        
        var viewModel: AlertViewModel?
        
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
        }
    }
    
}

