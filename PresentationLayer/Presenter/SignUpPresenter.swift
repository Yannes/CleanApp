//
//  SignUpPresenter.swift
//  PresentationLayer
//
//  Created by Yannes Meneguelli on 15/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation
import Domain


public final  class SignUpPresenter {
    
    private let alertView:AlertView
    private let emailValidator:EmailValidator
    private let addAccount:AddAccount
    
    public  init(alertView: AlertView, emailValidator:  EmailValidator,addAccount:AddAccount) {
        self.alertView = alertView
        self.emailValidator = emailValidator
        self.addAccount = addAccount
    
    }
    
    public   func signUp(viewModel: SignUpViewModel){
        if let message = validate(viewModel: viewModel){
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        }else {
            let addAccountModel = AddAccountModel(name: viewModel.name!, email: viewModel.email!, password: viewModel.password!, passwordConfirmation: viewModel.passwordConfirmation!)
            addAccount.add(addAccountModel: addAccountModel) { _ in}
        }
    }
    
    
    private func validate(viewModel: SignUpViewModel) -> String?{
        if viewModel.name == nil ||  viewModel.name!.isEmpty {
            return "O Campo Nome é Obrigatorio"
        }else if viewModel.email == nil ||  viewModel.email!.isEmpty {
            return "O Campo Email é Obrigatorio"
        }else if viewModel.password == nil ||  viewModel.password!.isEmpty {
            return "O Campo Senha é Obrigatorio"
        }else if viewModel.passwordConfirmation == nil ||  viewModel.passwordConfirmation!.isEmpty {
            return "O Campo Confirmar Senha é Obrigatorio"
        }else if viewModel.passwordConfirmation != viewModel.password  {
            return "O Campo Confirmar Senha é invalido"
        }else if !emailValidator.isValid(email: viewModel.email!){
            return "O Campo Email é invalido"
        }
        return nil
    }
}


public struct SignUpViewModel{
    public  var name: String?
    public  var email: String?
    public  var password: String?
    public  var passwordConfirmation: String?
    
    
    public init(name:String? = nil, email:String? = nil, password:String? = nil, passwordConfirm:String? = nil){
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirm
    }
    
    
    
    
}
