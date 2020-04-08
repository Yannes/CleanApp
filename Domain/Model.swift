//
//  Model.swift
//  Domain
//
//  Created by Yannes Meneguelli on 08/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation



public protocol Model:Encodable {}


public extension Model{
    func toData() -> Data? {
       return try? JSONEncoder().encode(self)
    }
}
