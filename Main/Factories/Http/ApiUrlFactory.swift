//
//  ApiUrlFactory.swift
//  Main
//
//  Created by Yannes Meneguelli on 21/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//
import Foundation

func makeApiUrl(path:String) -> URL{
    return URL(string: "\(Enviroment.variable(.apiBaseUrl))/\(path)")!
}
