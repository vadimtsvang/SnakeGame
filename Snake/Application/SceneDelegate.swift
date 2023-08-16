//
//  SceneDelegate.swift
//  Snake
//
//  Created by Vadim on 13.03.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = SetupViewController()
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .light
    }
}
