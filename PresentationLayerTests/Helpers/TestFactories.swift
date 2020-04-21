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
  
  
