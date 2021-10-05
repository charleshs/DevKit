import Foundation

extension Optional where Wrapped: Collection {
    public var isEmptyOrNil: Bool {
        return self?.isEmpty ?? true
    }

    public func emptyWhenNil() -> [Wrapped.Element] {
        return self == nil ? [] : Array(self!)
    }

    public func nilWhenEmpty() -> [Wrapped.Element]? {
        return isEmptyOrNil ? nil : Array(self!)
    }

    public func stringValue(fallback: String = "") -> String where Wrapped: StringProtocol {
        return self == nil ? fallback : String(self!)
    }

    public func nilWhenEmpty() -> String? where Wrapped: StringProtocol {
        return isEmptyOrNil ? nil : String(self!)
    }
}
