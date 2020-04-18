//
//  testExtension.swift
//  UITests
//
//  Created by Yannes Meneguelli on 17/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation
import UIKit

extension UIControl {
    func simulate(event:UIControl.Event){
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach{ action in
                (target as NSObject).perform(Selector(action))
            }
        }
    }
    
    func simulateTap(){
        simulate(event: .touchUpInside)
    }
}
