//
//  GradientDemoViewController.swift
//  DevKit-iosDemo
//
//  Created by Charles Hsieh on 2021/7/24.
//

import UIKit
import DevKit

final class GradientDemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        view.backgroundColor = .systemBackground

        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(view.safeAreaLayoutGuide)
        }

        stackView.addArrangedSubviews(verticalGradientView, horizontalGradientView, diagonalGradientView)
    }

    private func putLabelCentered(in targetView: UIView, text: String) {
        let label = UILabel()
        label.text = text
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel

        targetView.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    private lazy var verticalGradientView: GradientView = {
        let view = GradientView()
        view.drawGradient(direction: .vertical(start: 0, end: 1))
        view.setColors([
            UIColor.white.withAlphaComponent(0),
            UIColor.red.withAlphaComponent(0.6),
        ])
        putLabelCentered(in: view, text: "Vertical")
        return view
    }()

    private lazy var horizontalGradientView: GradientView = {
        let view = GradientView()
        view.drawGradient(direction: .horizontal(start: 0, end: 1))
        view.setColors([
            UIColor.white.withAlphaComponent(0),
            UIColor.green.withAlphaComponent(0.6),
        ])
        putLabelCentered(in: view, text: "Horizontal")
        return view
    }()

    private lazy var diagonalGradientView: GradientView = {
        let view = GradientView()
        view.setStartPoint(CGPoint(x: 0, y: 0))
        view.setEndPoint(CGPoint(x: 1, y: 1))
        view.setColors([
            UIColor.white.withAlphaComponent(0),
            UIColor.blue.withAlphaComponent(0.6),
        ])
        putLabelCentered(in: view, text: "Diagonal")
        return view
    }()

    private lazy var stackView: UIStackView = {
        let view = UIStackView(axis: .vertical, spacing: 0, distribution: .fillEqually, alignment: .fill)
        return view
    }()
}
