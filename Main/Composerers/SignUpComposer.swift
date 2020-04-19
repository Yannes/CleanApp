//
//  SignUpComposser.swift
//  Main
//
//  Created by Yannes Meneguelli on 19/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation
import Domain
import UI



public final class SignUpComposer{
    static func composeControllerWith(addAccount:AddAccount) ->  SignUpViewController{
        return ControllerFactory.makeController(addAccount: addAccount)
    }
}
