//
//  ComponentViewController.swift
//  DevKit-iosDemo
//
//  Created by Charles Hsieh on 2021/9/8.
//

import UIKit
import DevKit

final class ComponentViewController: UIViewController {
    private let viewBuilder: () -> UIView
    private let configurator: (UIView) -> Void

    init(viewBuilder: @escaping () -> UIView, configurator: @escaping (UIView) -> Void) {
        self.viewBuilder = viewBuilder
        self.configurator = configurator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        let componentView = viewBuilder()
        view.addSubview(componentView)
        configurator(componentView)
    }
}
