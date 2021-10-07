import Foundation

extension Optional where Wrapped: Collection {
    public var isEmptyOrNil: Bool {
        return self?.isEmpty ?? true
    }

    public func emptyWhenNil() -> [Wrapped.Element] {
        return map { Array($0) } ?? []
    }

    public func mapEmptyToNil() -> [Wrapped.Element]? {
        return isEmptyOrNil ? nil : Array(self!)
    }
}

extension Optional where Wrapped: StringProtocol {
    public func unwrapped(default: String = "") -> String {
        return map { String($0) } ?? `default`
    }

    public func mapEmptyToNil() -> String? {
        return isEmptyOrNil ? nil : String(self!)
    }
}
