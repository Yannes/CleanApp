//
//  Model.swift
//  Domain
//
//  Created by Yannes Meneguelli on 08/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation



public protocol Model:Codable,Equatable {}


public extension Model{
    func toData() -> Data? {
       return try? JSONEncoder().encode(self)
    }
    
    func toJson() -> [String: Any]? {
        guard let data = self.toData() else {return nil}
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any]
       }
    
    
}

