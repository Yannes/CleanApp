//
//  Validation.swift
//  PresentationLayer
//
//  Created by Yannes Meneguelli on 20/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation

public protocol Validation{
    func validate(data: [String: Any]?) -> String?
    
}
