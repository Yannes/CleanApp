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
    private let loadingView:LoadingView
    private let addAccount:AddAccount
    private let validation: Validation
    
    public  init(alertView: AlertView,addAccount:AddAccount, loadingView: LoadingView, validation: Validation ) {
        self.alertView = alertView
        self.addAccount = addAccount
        self.loadingView = loadingView
        self.validation = validation
    }
    
    public   func signUp(viewModel: SignUpViewModel){
        
        
        if let message = validation.validate(data: viewModel.toJson()){
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        }else {
            loadingView.display(viewModel: LoadingViewModel(isLoading: true))
            addAccount.add(addAccountModel: SignUpMapper.toAddAccountModel(viewModel:viewModel)) {[weak self] result in
                guard let self = self else {return}
                self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
                switch result {
                case.failure:
                    self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Algo de inesperado aconteceu tente novamente em alguns instantes"))
                case .success:
                    self.alertView.showMessage(viewModel: AlertViewModel(title: "Sucesso", message: "Conta criada com sucesso."))
                }
            }
        }
    }
}
