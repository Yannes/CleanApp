//
//  RoundedTextField.swift
//  UI
//
//  Created by Yannes Meneguelli on 22/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation
import UIKit


public final class RoundedTextField: UITextField{
    
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        setup()
    }
    private func setup(){
        layer.borderColor = #colorLiteral(red: 0.5333333333, green: 0.1652947865, blue: 0.3098039216, alpha: 1)
        layer.borderWidth = 1
        layer.cornerRadius = 5
    }
}
