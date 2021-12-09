import Foundation

public protocol ReadWriteWorker {
    func safeRead<T>(_ block: @escaping () -> T) -> T
    func safeWrite(_ block: @escaping () -> Void)
}
