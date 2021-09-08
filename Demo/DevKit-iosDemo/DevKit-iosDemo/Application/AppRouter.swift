//
//  AppRouter.swift
//  DevKit-iosDemo
//
//  Created by Charles Hsieh on 2021/7/23.
//

import UIKit

final class AppRouter {

    static func newRootNavVC() -> UINavigationController {
        let nav = UINavigationController(rootViewController: newMainVC())
        return nav
    }

    static func newMainVC() -> UIViewController {
        return MainViewController()
    }
}
