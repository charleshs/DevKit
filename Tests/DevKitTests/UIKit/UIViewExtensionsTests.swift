import DevKit
import XCTest
import UIKit

final class UIViewExtensionsTests: XCTestCase {
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
        rootView.addSubviews(imageView, outerLabel, wrapperView)
        wrapperView.addSubviews(innerLabel, button)
    }

    override func tearDown() {
        super.tearDown()
        rootView.demolishHierarchy()
    }

    func testFindSubviewsWithPredicate() {
        let testee = rootView.findSubviews(where: { $0 is UIControl })
        assertSameComposition(testee, expected: [button])
    }

    func testFindSubviewsWithClassName() {
        let testee = rootView.findSubviews(withClassName: "UIImageView")
        assertSameComposition(testee, expected: [imageView])
    }

    func testGetSubviewsOfType() {
        let testee: [UILabel] = rootView.findSubviews()
        assertSameComposition(testee, expected: [innerLabel, outerLabel])
    }

    func testDemolishHierarchy() {
        assertNotEmptyHierarchyOfViews(rootView, wrapperView)
        rootView.demolishHierarchy()
        assertEmptyHierarchyOfViews(rootView, wrapperView)
    }

    func testParentViewController() {
        let viewController = UIViewController()
        viewController.view.addSubview(rootView)
        XCTAssertEqual(button.parentViewController, viewController)
    }

    func testParentViewController_inChildVC() {
        let rootVC = UIViewController()
        let childVC = UIViewController()
        rootVC.addChild(childVC)
        rootVC.view.addSubview(childVC.view)
        childVC.didMove(toParent: rootVC)
        childVC.view.addSubview(rootView)
        XCTAssertEqual(button.parentViewController, childVC)
    }

    func testParentViewControllerNotFound() {
        XCTAssertNil(wrapperView.parentViewController)
    }

    func testClone() {
        let copy = wrapperView.clone()
        XCTAssertNotEqual(wrapperView, copy)
        XCTAssertEqual(copy.subviews.count, wrapperView.subviews.count)
    }

    private func assertEmptyHierarchyOfViews(_ views: UIView...) {
        views.forEach { XCTAssertEqual($0.subviews.isEmpty, true) }
    }

    private func assertNotEmptyHierarchyOfViews(_ views: UIView...) {
        views.forEach { XCTAssertEqual($0.subviews.isEmpty, false) }
    }

    private func assertSameComposition<T>(_ testee: [T], expected: [T]) where T: Hashable {
        XCTAssertEqual(Set(testee), Set(expected))
    }
}
