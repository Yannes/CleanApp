//
//  NavigationController.swift
//  UI
//
//  Created by Yannes Meneguelli on 22/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation
import UIKit

public final class NavigationController: UINavigationController{
    
    
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(){
        navigationBar.barTintColor = #colorLiteral(red: 0.5, green: 0.05490196078, blue: 0.3098039216, alpha: 1)
        navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.isTranslucent = false
        navigationBar.barStyle = .black
    }
}
