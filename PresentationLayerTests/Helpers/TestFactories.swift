//
//  TestFactories.swift
//  PresentationLayerTests
//
//  Created by Yannes Meneguelli on 17/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation
import PresentationLayer
import Domain


func makesignUpViewModel(name:String? = "any_name",email:String? = "any_email@email.com",password:String? = "any_pass",passwordConfirm:String? = "any_pass") -> SignUpViewModel{
      return SignUpViewModel(name: name, email: email, password: password, passwordConfirm: passwordConfirm)
  }
  
  
  
  func makeRequiredAlertViewModel(fieldName:String) ->AlertViewModel{
      return AlertViewModel(title:"Falha na validação",message:"O Campo \(fieldName) é Obrigatorio")
  }
  
  func makeInvalidAlertViewModel(fieldName:String) ->AlertViewModel{
      return AlertViewModel(title:"Falha na validação",message:"O Campo \(fieldName) é invalido")
  }
  
  func makeAddAccountModel() -> AddAccountModel{
      return AddAccountModel(name: "any_name", email: "any_email@email.com", password: "any_pass", passwordConfirmation: "any_pass")
  }
  
  
  func makeErrorAlertViewModel(message:String) ->AlertViewModel{
      return AlertViewModel(title:"Erro",message: message)
  }
  
  
  func makeSuccessAlertViewModel(message:String) ->AlertViewModel{
         return AlertViewModel(title:"Sucesso",message: message)
  }
     
  
  func makeAccountModel() -> AccountModel{
     return AccountModel(id: "any_account", name: "Any_name", email: "any_email@hotmail.com", password: "any_password")
  }

  
