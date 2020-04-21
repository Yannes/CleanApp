//
//  ValidationComposite.swift
//  Validation
//
//  Created by Yannes Meneguelli on 21/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation
import PresentationLayer

public final class ValidationComposite:Validation{
    
    var validations = [Validation]()
    
    public init(validations:[Validation]){
        self.validations = validations
    }
    
    
    public  func validate(data: [String : Any]?) -> String? {
        for validation in validations {
            if let errorMessage = validation.validate(data: data){
                return  errorMessage
            }
        }
        return nil
    }
}
