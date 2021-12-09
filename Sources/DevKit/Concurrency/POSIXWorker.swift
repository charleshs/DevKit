import Foundation

public final class POSIXWorker {
    var lock = pthread_rwlock_t()

    public init() {
        pthread_rwlock_init(&lock, nil)
    }

    deinit {
        pthread_rwlock_destroy(&lock)
    }
}

extension POSIXWorker: ReadWriteWorker {
    public func safeRead<T>(_ block: @escaping () -> T) -> T {
        pthread_rwlock_rdlock(&lock)
        let value = block()
        pthread_rwlock_unlock(&lock)
        return value
    }

    public func safeWrite(_ block: @escaping () -> Void) {
        pthread_rwlock_wrlock(&lock)
        block()
        pthread_rwlock_unlock(&lock)
    }
}
