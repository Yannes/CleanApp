//
//  SingupFactory.swift
//  Main
//
//  Created by Yannes Meneguelli on 19/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation
import UI
import PresentationLayer
import Validation
import Data
import Domain


class ControllerFactory {
    static func makeController(addAccount: AddAccount) -> SignUpViewController{
        let controller = SignUpViewController.instantiate()
        let emailValidatorAdapter = EmailValidatorAdapter()
        let presenter = SignUpPresenter(alertView: WeakVarProxy(controller), emailValidator: emailValidatorAdapter, addAccount: addAccount, loadingView: WeakVarProxy(controller))
        controller.signUp = presenter.signUp
        return controller
    }
}


class WeakVarProxy<T:AnyObject> {
    
    private weak var instance: T?
 
    init(_ instance: T){
        self.instance = instance
    }
}



extension WeakVarProxy: AlertView where T: AlertView{
    func showMessage(viewModel: AlertViewModel) {
        instance?.showMessage(viewModel: viewModel)
    }
}


extension WeakVarProxy: LoadingView where T: LoadingView{
    func display(viewModel: LoadingViewModel) {
        instance?.display(viewModel: viewModel)
    }
}
