//
//  AppDelegate.swift
//  DevKit-iosDemo
//
//  Created by Charles Hsieh on 2021/7/23.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        if #available(iOS 13.0, *) {
            // Handled by SceneDelegate
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = AppRouter.newRootNavVC()
            window?.makeKeyAndVisible()
        }

        return true
    }

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
