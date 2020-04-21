//
//  ValidationSpy.swift
//  PresentationLayerTests
//
//  Created by Yannes Meneguelli on 20/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation
import PresentationLayer



class ValidationSpy:Validation {
    var data: [String: Any]?
    var errorMessage: String?
    
    func validate(data: [String : Any]?) -> String? {
        self.data = data
        return errorMessage
    }
    
    
    
    func simulateError(){
        self.errorMessage = "Erro"
    }
    
    
}
