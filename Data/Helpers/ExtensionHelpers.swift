//
//  ExtensionHelpers.swift
//  Data
//
//  Created by Yannes Meneguelli on 09/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation


extension Data {
    func toModel<T:Decodable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }  
}

