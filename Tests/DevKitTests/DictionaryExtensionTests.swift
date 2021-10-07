import DevKit
import Foundation
import XCTest

final class DictionaryExtensionTests: XCTestCase {
    func testJsonEncoded_serializableContent() throws {
        let payload = ["testField": "testValue"]
        XCTAssertNotNil(payload.jsonEncodedData())
        XCTAssertNotNil(payload.jsonSafeEncodedData())
    }

    func testJsonEncoded_failingCase() {
        let testee = ["request": URLRequest(url: URL(string: "https://www.google.com")!)].jsonSafeEncodedData()
        XCTAssertNil(testee)
    }
}
