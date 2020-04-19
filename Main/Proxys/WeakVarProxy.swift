//
//  WeakVarProxy.swift
//  Main
//
//  Created by Yannes Meneguelli on 19/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation
import PresentationLayer

final class WeakVarProxy<T:AnyObject> {
    
    private weak var instance: T?
 
    init(_ instance: T){
        self.instance = instance
    }
}

extension WeakVarProxy: AlertView where T: AlertView{
    func showMessage(viewModel: AlertViewModel) {
        instance?.showMessage(viewModel: viewModel)
    }
}


extension WeakVarProxy: LoadingView where T: LoadingView{
    func display(viewModel: LoadingViewModel) {
        instance?.display(viewModel: viewModel)
    }
}
