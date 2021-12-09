import DevKit
import XCTest

final class ObservedTests: XCTestCase {
    @Observed(queue: .main) var username: String = ""

    func testSubscribe() {
        let myName = "Charles"
        let promise = expectation(description: #function)

        $username.subscribe(firesOnSubscribed: false) { newName in
            XCTAssertEqual(newName, myName)
            promise.fulfill()
        }
        username = myName
        wait(for: [promise], timeout: 10)
    }
}
