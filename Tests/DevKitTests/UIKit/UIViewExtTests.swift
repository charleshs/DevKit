import DevKit
import XCTest
import UIKit

final class UIViewExtTests: XCTestCase {
    private let rootView = UIView()
    private let imageView = UIImageView()
    private let outerLabel = UILabel()
    private let wrapperView = UIView()
    private let innerLabel = UILabel()
    private let button = UIButton()

    override func setUp() {
        super.setUp()
        /**
         Hierarchy:

         rootView > imageView
                  > outerLabel
                  > wrapperView > innerLabel
                                > button
         */
        rootView.addSubview(imageView)
        rootView.addSubview(outerLabel)
        rootView.addSubview(wrapperView)
        wrapperView.addSubview(innerLabel)
        wrapperView.addSubview(button)
    }

    override func tearDown() {
        super.tearDown()
        rootView.demolishHierarchy()
    }

    func testFindSubviewsWithPredicate() {
        let testee = rootView.findSubviews(where: { $0 is UIControl })
        checkComposition(testee, expected: [button])
    }

    func testFindSubviewsWithClassName() {
        let testee = rootView.findSubviews(withClassName: "UIImageView")
        checkComposition(testee, expected: [imageView])
    }

    func testGetSubviewsOfType() {
        let testee: [UILabel] = rootView.getSubviews()
        checkComposition(testee, expected: [innerLabel, outerLabel])
    }

    func testDemolishHierarchy() {
        checkRootAndWrapperView(isEmpty: false)
        rootView.demolishHierarchy()
        checkRootAndWrapperView(isEmpty: true)
    }

    private func checkRootAndWrapperView(isEmpty: Bool) {
        [rootView, wrapperView].forEach { view in
            XCTAssertEqual(view.subviews.isEmpty, isEmpty)
        }
    }

    private func checkComposition<T>(_ testee: [T], expected: [T]) where T: Hashable {
        XCTAssertEqual(Set(testee), Set(expected))
    }
}
