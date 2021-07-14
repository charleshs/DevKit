import DevKit
import XCTest

final class UserDefaultsWrapperTests: XCTestCase {
    struct K {
        static let defaultValue = "DefaultValue"
        static let keyTestString = "TestString"
    }

    @UserDefaultsWrapper(key: K.keyTestString, defaultValue: K.defaultValue)
    private var testString: String?

    override class func tearDown() {
        UserDefaults.standard.removeObject(forKey: K.keyTestString)
    }

    func testDefaultValue() {
        clearTestStringInUserDefaults()
        XCTAssertNil(UserDefaults.standard.string(forKey: K.keyTestString))
        XCTAssertEqual(testString, K.defaultValue)
    }

    func testSetter() {
        clearTestStringInUserDefaults()
        testString = #function
        let testee = UserDefaults.standard.string(forKey: K.keyTestString)
        XCTAssertEqual(testee, #function)
    }

    func testGetter() {
        UserDefaults.standard.set(#filePath, forKey: K.keyTestString)
        XCTAssertEqual(testString, #filePath)
    }

    private func clearTestStringInUserDefaults() {
        UserDefaults.standard.removeObject(forKey: K.keyTestString)
    }
}
