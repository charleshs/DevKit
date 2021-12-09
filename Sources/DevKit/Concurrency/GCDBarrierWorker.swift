import Foundation

public struct GCDBarrierWorker {
    let queue: DispatchQueue

    public init(qos: DispatchQoS = .default) {
        let typeName = String(describing: GCDBarrierWorker.self)
        let uuidPrefix = UUID().uuidString.prefix(6)
        let identifier = "queue.\(typeName)-\(uuidPrefix)"
        self.queue = DispatchQueue(label: identifier, qos: qos, attributes: .concurrent)
    }
}

extension GCDBarrierWorker: ReadWriteWorker {
    public func safeRead<T>(_ block: @escaping () -> T) -> T {
        queue.sync {
            let value = block()
            return value
        }
    }

    public func safeWrite(_ block: @escaping () -> Void) {
        let workItem = DispatchWorkItem(flags: .barrier, block: block)
        queue.sync(execute: workItem)
    }
}
