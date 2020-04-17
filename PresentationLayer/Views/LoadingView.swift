//
//  LoadingView.swift
//  PresentationLayer
//
//  Created by Yannes Meneguelli on 17/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation

public protocol LoadingView{
    func display(viewModel: LoadingViewModel)
}



public struct LoadingViewModel: Equatable{
    public var isLoading: Bool
    
    
    public init(isLoading: Bool){
        self.isLoading  = isLoading
    }
    
}
