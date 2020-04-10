//
//  HttpError.swift
//  Data
//
//  Created by Yannes Meneguelli on 08/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation

public enum HttpError: Error{
    case noConnectivity
    case badRequest
    case serverError
    case unauthorized
    case forbidden
}
