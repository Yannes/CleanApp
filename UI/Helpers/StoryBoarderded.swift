//
//  StoryBordered.swift
//  UI
//
//  Created by Yannes Meneguelli on 18/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation
import UIKit


public protocol StoryBoarderded{
    static func instantiate() -> Self
}


extension StoryBoarderded where Self: UIViewController{
    
    public static func instantiate() -> Self{
        let vcName = String(describing: self)
        let sbName = vcName.components(separatedBy: "ViewController")[0]
        let bundle = Bundle(for: Self.self)
        let sb = UIStoryboard(name: sbName, bundle: bundle )
        return sb.instantiateViewController(identifier: vcName) as! Self
    }
}
