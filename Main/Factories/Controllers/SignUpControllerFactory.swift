//
//  SignUpComposser.swift
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


public func makeSignUpController(addAccount: AddAccount) -> SignUpViewController{
        let controller = SignUpViewController.instantiate()
        let validationComposite = ValidationComposite(validations: makesignUpValidation())
        let presenter = SignUpPresenter(alertView: WeakVarProxy(controller), addAccount: addAccount, loadingView: WeakVarProxy(controller),validation: validationComposite)
        controller.signUp = presenter.signUp
        return controller
    }

public func makesignUpValidation() ->  [Validation]{
      return [
          RequiredFieldValidation(fieldName: "name", fieldLabel: "Nome"),
          RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"),
          EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: makeEmailValidatorAdapter()),
          RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha"),
          RequiredFieldValidation(fieldName: "passwordConfirmation", fieldLabel: "Confirmar Senha"),
          CompareFieldsValidation(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Confirmar Senha")
      ]
  }
