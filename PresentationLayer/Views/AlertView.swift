//
//  AlertView.swift
//  PresentationLayer
//
//  Created by Yannes Meneguelli on 15/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation

public protocol AlertView {
    func showMessage(viewModel:  AlertViewModel)
}


public struct  AlertViewModel:Equatable {
   public  var title: String
   public  var message:String
    
    
    public init(title:String,message:String){
        self.title = title
        self.message = message
    }
    
    
    
}


