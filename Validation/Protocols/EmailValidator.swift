//
//  EmailValidator.swift
//  PresentationLayer
//
//  Created by Yannes Meneguelli on 15/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation

public protocol EmailValidator {
    func isValid(email:String) ->Bool
}
