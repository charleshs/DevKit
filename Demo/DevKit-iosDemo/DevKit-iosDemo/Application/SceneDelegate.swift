//
//  SceneDelegate.swift
//  DevKit-iosDemo
//
//  Created by Charles Hsieh on 2021/7/23.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = AppRouter.newRootNavVC()
        window?.makeKeyAndVisible()

        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window = window
        }
    }
}
