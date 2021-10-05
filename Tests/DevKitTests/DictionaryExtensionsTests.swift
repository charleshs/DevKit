import DevKit
import Foundation
import XCTest

final class DictionaryExtensionsTests: XCTestCase {
    func testJsonEncoded_serializableContent() throws {
        let payload = ["testField": "testValue"]
        XCTAssertNotNil(payload.jsonEncoded())
        XCTAssertNotNil(payload.jsonEncodedSafely())
    }

    func testJsonEncoded_failingCase() {
        let testee = ["request": URLRequest(url: URL(string: "https://www.google.com")!)].jsonEncodedSafely()
        XCTAssertNil(testee)
    }
}
