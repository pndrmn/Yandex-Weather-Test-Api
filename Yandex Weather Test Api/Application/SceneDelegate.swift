//
//  SceneDelegate.swift
//  Yandex Weather Test Api
//
//  Created by Roman Gorodilov on 08.08.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowsScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame:UIScreen.main.bounds)
        
        window?.windowScene = windowsScene
        
        window?.makeKeyAndVisible()
        
        window?.rootViewController = UINavigationController(rootViewController: MainViewController())
    }
}

