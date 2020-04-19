//
//  Enviroment.swift
//  Main
//
//  Created by Yannes Meneguelli on 19/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation


public final class Enviroment{
  
   public  enum EnviromentVariables: String{
        case apiBaseUrl = "API_BASE_URL"
    }
    
   public static func variable(_ key: EnviromentVariables) -> String{
        return Bundle.main.infoDictionary![key.rawValue] as! String
    }
}
