import DevKit
import UIKit
import XCTest

final class GradientViewTests: XCTestCase {
    func testInit() throws {
        let view = GradientView()
        _ = try XCTUnwrap(view.gradientLayer)
    }

    func testMethods() throws {
        let view = GradientView()
        let layer = try XCTUnwrap(view.gradientLayer)

        view.setColors([.clear, .black.withAlphaComponent(0.5)])
        view.setStartPoint(CGPoint(x: 0, y: 0))
        view.setEndPoint(CGPoint(x: 0, y: 1))
        view.setLocations([0.25, 0.75])

        XCTAssertEqual(layer.colors as! [CGColor],
                       [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.5).cgColor])
        XCTAssertEqual(layer.startPoint, CGPoint(x: 0, y: 0))
        XCTAssertEqual(layer.endPoint, CGPoint(x: 0, y: 1))
        XCTAssertEqual(layer.locations, [0.25, 0.75])
    }

    func testDrawGradient() throws {
        let view = GradientView()
        let layer = try XCTUnwrap(view.gradientLayer)

        view.drawGradient(direction: .vertical(start: 0.25, end: 0.75))
        XCTAssertEqual(layer.startPoint.y, 0.25)
        XCTAssertEqual(layer.endPoint.y, 0.75)

        view.drawGradient(direction: .horizontal(start: 0.75, end: 0.25))
        XCTAssertEqual(layer.startPoint.x, 0.75)
        XCTAssertEqual(layer.endPoint.x, 0.25)
    }
}
