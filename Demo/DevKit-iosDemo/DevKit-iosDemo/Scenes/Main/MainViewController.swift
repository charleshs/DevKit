//
//  MainViewController.swift
//  DevKit-iosDemo
//
//  Created by Charles Hsieh on 2021/7/23.
//

import UIKit
import SnapKit
import DevKit

final class MainViewController: UIViewController {

    deinit {
        print("deinit - \(self)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        feedData()
    }

    private func setup() {
        title = "DevKitDemo"
        view.backgroundColor = .white
        layoutTableView()
    }

    private func feedData() {
        renderer.display(sections: [
            StaticSection(title: "UI Components", rows: [
                StaticRow(title: "Gradient Demo", subtitle: nil, accessory: .disclosureIndicator) { [weak self] in
                    self?.show(MainRouter.newGradientDemoVC(), sender: nil)
                },
            ]),
        ])
    }

    private func layoutTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
    }

    private lazy var renderer = StaticListRenderer(tableView: tableView)
    private lazy var tableView = UITableView(frame: .zero, style: .grouped)
}
