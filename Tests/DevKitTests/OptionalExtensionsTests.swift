import DevKit
import Foundation
import XCTest

final class OptionalExtensionsTests: XCTestCase {
    func testIsEmptyOrNil() {
        var nums: [Int]? = [1, 2, 3, 4, 5]
        XCTAssertFalse(nums.isEmptyOrNil)

        nums = []
        XCTAssertTrue(nums.isEmptyOrNil)

        nums = nil
        XCTAssertTrue(nums.isEmptyOrNil)
    }

    func testEmptyWhenNil() {
        var nums: [Int]? = nil
        XCTAssertEqual(nums.emptyWhenNil(), [])

        nums = [1, 2, 3]
        XCTAssertEqual(nums.emptyWhenNil(), [1, 2, 3])
    }

    func testRejectEmpty() {
        var nums: [Int]? = []
        XCTAssertNil(nums.nilWhenEmpty())

        nums = [1, 2, 3]
        XCTAssertEqual(nums.nilWhenEmpty(), [1, 2, 3])

        var text: String? = ""
        XCTAssertNil(text.nilWhenEmpty())

        text = "String"
        XCTAssertEqual(text.nilWhenEmpty(), "String")
    }

    func testStringValue() {
        var text: String? = nil
        XCTAssertEqual(text.stringValue(), "")
        XCTAssertEqual(text.stringValue(fallback: "n/a"), "n/a")

        text = "String"
        XCTAssertEqual(text.stringValue(), "String")
    }
}
