//
//  SignUpMapper.swift
//  PresentationLayer
//
//  Created by Yannes Meneguelli on 17/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation
import Domain

public final class  SignUpMapper{
    static func toAddAccountModel(viewModel:SignUpViewModel) -> AddAccountModel{
        return AddAccountModel(name: viewModel.name!, email: viewModel.email!, password: viewModel.password!, passwordConfirmation: viewModel.passwordConfirmation!)
    }
}
