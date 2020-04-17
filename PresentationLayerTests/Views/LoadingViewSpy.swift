//
//  LoadingViewSpy.swift
//  PresentationLayerTests
//
//  Created by Yannes Meneguelli on 17/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation
import PresentationLayer

class LoadingViewSpy: LoadingView {
    
    var emit: ((LoadingViewModel)->Void)?
      
    func observe(completion: @escaping(LoadingViewModel)->Void){
          self.emit = completion
      }

    func display(viewModel: LoadingViewModel) {
        self.emit?(viewModel)
    }
}
