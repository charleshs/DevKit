import DevKit
import XCTest

final class ReadWriteWorkerTests: XCTestCase {
    func testGCDBarrier() {
        let worker = GCDBarrierWorker()
        assertNoRaceCondition(for: worker)
        XCTAssertEqual(worker.safeRead { return 1 }, 1)
    }

    func testNSLock() {
        let worker = NSLockWorker()
        assertNoRaceCondition(for: worker)
        XCTAssertEqual(worker.safeRead { return 1 }, 1)
    }

    func testPOSIX() {
        let worker = POSIXWorker()
        assertNoRaceCondition(for: worker)
        XCTAssertEqual(worker.safeRead { return 1 }, 1)
    }

    private func assertNoRaceCondition<Worker: ReadWriteWorker>(for worker: Worker) {
        let taskCount = 50000

        var counter = 0

        for i in 0 ..< taskCount {
            let promise = expectation(description: i.description)

            DispatchQueue.global().async {
                worker.safeWrite {
                    counter += 1
                }
                promise.fulfill()
            }
        }

        waitForExpectations(timeout: 10) { _ in
            XCTAssertEqual(counter, taskCount)
        }
    }
}

final class ThreadSafeWorkerMeasureTests: XCTestCase {
    func testMeasureGCDBarrier() {
        let worker = GCDBarrierWorker()
        measure {
            executionTime(for: worker)
        }
    }

    func testMeasureNSLock() {
        let worker = NSLockWorker()
        measure {
            executionTime(for: worker)
        }
    }

    func testMeasurePOSIX() {
        let worker = POSIXWorker()
        measure {
            executionTime(for: worker)
        }
    }

    private func executionTime<Worker: ReadWriteWorker>(for worker: Worker) {
        let taskCount = 200000
        var counter = 0
        for _ in 0 ..< taskCount {
            worker.safeWrite {
                counter += 1
            }
        }
    }
}
