//
//  UIViewControllerExtension.swift
//  UI
//
//  Created by Yannes Meneguelli on 18/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func hideKeyBoardOnTap(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
    }
    
    @objc private func hideKeyBoard(){
        view.endEditing(true)
    }
    
    
}
