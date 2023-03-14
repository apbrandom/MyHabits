//
//  SceneDelegate.swift
//  MyHabits
//
//  Created by Вадим Виноградов on 07.03.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        
        let controllers = [
            HabitsViewController(),
            InfoViewController(),
        ]
        
        let tabBarVC = UITabBarController()
        
        tabBarVC.viewControllers = controllers.map {
            let _ = $0.view
            return UINavigationController(rootViewController: $0)
        }
        
        UINavigationBar.appearance().prefersLargeTitles = true

        window.rootViewController = tabBarVC
        window.makeKeyAndVisible()
        window.tintColor = .systemPurple
        
        self.window = window
    }
}










