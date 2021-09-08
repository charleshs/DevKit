//
//  MainRouter.swift
//  DevKit-iosDemo
//
//  Created by Charles Hsieh on 2021/7/25.
//

import UIKit
import DevKit

struct MainRouter {
    static func newGradientDemoVC() -> UIViewController {
        return GradientDemoViewController()
    }

    static func highlightButtonComponentVC() -> UIViewController {
        return ComponentViewController {
            HighlightButton(highlightedColor: .lightGray, normalColor: .systemGreen)
        } configurator: { view in
            guard let superview = view.superview else { return }

            view.backgroundColor = .systemGreen
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.frame.size = CGSize(width: 120, height: 44)
            view.center = superview.center
            view.layer.cornerRadius = 12

            if let button = view as? HighlightButton {
                button.setTitle("Click Me!", for: .normal)
                button.setTitleColor(.white, for: .normal)
            }
        }
    }
}
