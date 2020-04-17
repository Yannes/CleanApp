//
//  AlertViewSpy.swift
//  PresentationLayerTests
//
//  Created by Yannes Meneguelli on 17/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation
import PresentationLayer





class AlertViewSpy: AlertView {
    
    var emit: ((AlertViewModel)->Void)?
    
    
    func observe(completion: @escaping(AlertViewModel)->Void){
        self.emit = completion
    }
    
    func showMessage(viewModel: AlertViewModel) {
        self.emit?(viewModel)
    }
}
