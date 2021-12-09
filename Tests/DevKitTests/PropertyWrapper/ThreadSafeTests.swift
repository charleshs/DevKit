import DevKit
import XCTest

final class ThreadSafeArrayTests: XCTestCase {
    @ThreadSafe(worker: POSIXWorker())
    var array: [Int] = [1, 4, 2, 3, 5]

    func testReadAndWrite() {
        array[4] = 6
        XCTAssertEqual(array[1], 4)
        XCTAssertEqual(array, [1, 4, 2, 3, 6])
    }

    func testAppend() {
        array.append(6)
        XCTAssertEqual(array, [1, 4, 2, 3, 5, 6])
    }

    func testRemoveAll() {
        array.removeAll()
        XCTAssertEqual(array, [])
    }
}

final class ThreadSafeDictionaryTests: XCTestCase {
    @ThreadSafe(worker: POSIXWorker())
    var cache: [String: String] = [:]

    func testUpdateValue() {
        cache["foo"] = "bar"
        cache["hello"] = "world"
        XCTAssertEqual(cache, ["foo": "bar", "hello": "world"])
    }

    func testOverwriteValue() {
        let dict = ["yeah": "yo", "whoo": "ha"]
        cache = ["yeah": "yo", "whoo": "ha"]
        XCTAssertEqual(cache, dict)
    }
}

final class ThreadSafeObjectTests: XCTestCase {
    class Pet {
        var name: String
        var grams: Double

        init(name: String, grams: Double) {
            self.name = name
            self.grams = grams
        }
    }

    @ThreadSafe(worker: POSIXWorker())
    var hamster = Pet(name: "gueji", grams: 31.5)

    func testUpdateValueClosure() {
        $hamster.safeWrite { pet in
            pet.grams = 45
        }
        XCTAssertEqual(hamster.grams, 45)
    }
}
