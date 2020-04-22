//
//  SceneDelegate.swift
//  Main
//
//  Created by Yannes Meneguelli on 19/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let httpClient = makeAlamoFireAdapter()
        let addAcount = makeRemoteAddAccount(httpClient: httpClient)
        
        window?.rootViewController = makeSignUpController(addAccount:addAcount)
        window?.makeKeyAndVisible()
    }
}

