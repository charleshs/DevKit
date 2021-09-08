import DevKit
import XCTest

final class StoredInUserDefaultsTests: XCTestCase {
    enum Keys {
        static var allKeys: [String] = [TestString, TestInteger, TestBoolean]

        static let TestString = "TestString"
        static let TestInteger = "TestInteger"
        static let TestBoolean = "TestBoolean"
    }

    struct Constants {
        static let DefaultString = "DefaultString"
    }

    @StoredInUserDefaults(key: Keys.TestString, in: .testing, defaultValue: Constants.DefaultString)
    private var testString: String!

    @StoredInUserDefaults(key: Keys.TestInteger, in: .testing, defaultValue: 0)
    private var testInteger: Int!

    @StoredInUserDefaults(key: Keys.TestBoolean, in: .testing)
    private var testBoolean: Bool?

    override func tearDown() {
        Keys.allKeys.forEach(UserDefaults.testing.removeObject)
    }

    func testDefaultValue() {
        XCTAssertNil(UserDefaults.testing.string(forKey: Keys.TestString))
        XCTAssertEqual(testString, Constants.DefaultString)
    }

    func testStringStorage() {
        XCTAssertEqual(testString, Constants.DefaultString)
        testString = #function
        let testee = UserDefaults.testing.string(forKey: Keys.TestString)
        XCTAssertEqual(testee, #function)
        XCTAssertEqual(testee, testString)
    }

    func testIntegerStorage() {
        XCTAssertEqual(testInteger, 0)
        testInteger = 10_000
        let testee = UserDefaults.testing.integer(forKey: Keys.TestInteger)
        XCTAssertEqual(testee, testInteger)
    }

    func testBooleanStorage() {
        XCTAssertEqual(testBoolean, nil)
        testBoolean = false
        let testee = UserDefaults.testing.bool(forKey: Keys.TestBoolean)
        XCTAssertEqual(testee, testBoolean)
    }
}

private extension UserDefaults {
    static let testing = UserDefaults(suiteName: "com.charleshs.DevKitTests")!
}
