import Foundation

@propertyWrapper
public final class ThreadSafe<Value> {
    public var wrappedValue: Value {
        get {
            safeRead()
        }
        set {
            safeWrite(newValue)
        }
    }

    public var projectedValue: ThreadSafe<Value> {
        return self
    }

    private let worker: ReadWriteWorker
    private var value: Value

    public init<Worker: ReadWriteWorker>(wrappedValue: Value, worker: Worker) {
        self.value = wrappedValue
        self.worker = worker
    }

    public func safeRead() -> Value {
        worker.safeRead { [unowned self] in
            self.value
        }
    }

    public func safeWrite(_ value: Value) {
        worker.safeWrite { [unowned self] in
            self.value = value
        }
    }

    public func safeWrite(_ updates: @escaping (inout Value) -> Void) {
        worker.safeWrite { [unowned self] in
            updates(&self.value)
        }
    }
}
