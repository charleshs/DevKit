import Foundation

public struct NSLockWorker {
    let lock: NSLock

    public init() {
        self.lock = NSLock()
    }
}

extension NSLockWorker: ReadWriteWorker {
    public func safeRead<T>(_ block: @escaping () -> T) -> T {
        lock.lock()
        let value = block()
        lock.unlock()
        return value
    }

    public func safeWrite(_ block: @escaping () -> Void) {
        lock.lock()
        block()
        lock.unlock()
    }
}
