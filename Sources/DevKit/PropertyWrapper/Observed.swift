import Foundation

@propertyWrapper
public final class Observed<T> {
    public var wrappedValue: T {
        get { return value }
        set { self.value = newValue }
    }

    public var projectedValue: Observed<T> {
        return self
    }

    private var value: T { didSet {
        execute()
    }}

    private let queue: DispatchQueue?

    private var closure: ((T) -> Void)?

    public init(wrappedValue: T, queue: DispatchQueue? = nil) {
        self.value = wrappedValue
        self.queue = queue
    }
}

extension Observed {
    public func callAsFunction(firesOnSubscribed: Bool = true, onChanged closure: @escaping (T) -> Void) {
        self.subscribe(firesOnSubscribed: firesOnSubscribed, onChanged: closure)
    }

    public func subscribe(firesOnSubscribed: Bool = true, onChanged closure: @escaping (T) -> Void) {
        self.closure = closure
        if firesOnSubscribed { execute() }
    }

    public func cancel() {
        self.closure = nil
    }

    private func execute() {
        guard let closure = self.closure else { return }

        let value = value

        if let queue = queue, queue.shouldRunAsync {
            queue.async {
                closure(value)
            }
        } else {
            closure(value)
        }
    }
}

private extension DispatchQueue {
    var shouldRunAsync: Bool {
        !isAsyncRedundant
    }

    var isAsyncRedundant: Bool {
        self == DispatchQueue.main && Thread.isMainThread
    }
}
