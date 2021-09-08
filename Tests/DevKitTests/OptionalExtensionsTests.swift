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
        XCTAssertNil(nums.rejectEmpty())

        nums = [1, 2, 3]
        XCTAssertEqual(nums.rejectEmpty(), [1, 2, 3])

        var text: String? = ""
        XCTAssertNil(text.rejectEmpty())

        text = "String"
        XCTAssertEqual(text.rejectEmpty(), "String")
    }

    func testStringValue() {
        var text: String? = nil
        XCTAssertEqual(text.stringValue(), "")
        XCTAssertEqual(text.stringValue(or: "n/a"), "n/a")

        text = "String"
        XCTAssertEqual(text.stringValue(), "String")
    }
}
