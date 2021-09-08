import Foundation

extension Optional where Wrapped: Collection {
    public var isEmptyOrNil: Bool {
        return self?.isEmpty ?? true
    }

    public func emptyWhenNil() -> [Wrapped.Element] {
        return self == nil ? [] : Array(self!)
    }

    public func rejectEmpty() -> [Wrapped.Element]? {
        return isEmptyOrNil ? nil : Array(self!)
    }

    public func stringValue(or fallback: String = "") -> String where Wrapped: StringProtocol {
        return self == nil ? fallback : String(self!)
    }

    public func rejectEmpty() -> String? where Wrapped: StringProtocol {
        return isEmptyOrNil ? nil : String(self!)
    }
}
