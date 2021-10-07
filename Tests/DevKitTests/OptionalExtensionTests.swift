import DevKit
import Foundation
import XCTest

final class OptionalExtensionTests: XCTestCase {
    func testIsEmptyOrNil() {
        var vals: [Int]? = [1, 2, 3, 4, 5]
        XCTAssertFalse(vals.isEmptyOrNil)

        vals = []
        XCTAssertTrue(vals.isEmptyOrNil)

        vals = nil
        XCTAssertTrue(vals.isEmptyOrNil)
    }

    func testEmptyWhenNil() {
        var vals: [Int]? = nil
        XCTAssertEqual(vals.emptyWhenNil(), [])

        vals = [1, 2, 3]
        XCTAssertEqual(vals.emptyWhenNil(), [1, 2, 3])
    }

    func testMapEmptyToNil() {
        var vals: [Int]? = []
        XCTAssertNil(vals.mapEmptyToNil())

        vals = [1, 2, 3]
        XCTAssertEqual(vals.mapEmptyToNil(), [1, 2, 3])

        var text: String? = ""
        XCTAssertNil(text.mapEmptyToNil())

        text = "String"
        XCTAssertEqual(text.mapEmptyToNil(), "String")
    }

    func testUnwrapStrings() {
        var text: String? = nil
        XCTAssertEqual(text.unwrapped(), "")
        XCTAssertEqual(text.unwrapped(default: "n/a"), "n/a")

        text = "String"
        XCTAssertEqual(text.unwrapped(), "String")
    }
}
