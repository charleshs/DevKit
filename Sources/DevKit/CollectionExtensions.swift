import Foundation

extension Collection {
    public subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }

    public func asString() -> String where Element == Character {
        return String(self)
    }
}

extension MutableCollection {
    public mutating func changeElements(where predicate: (Element) -> Bool, using block: (inout Element) throws -> Void) rethrows {
        guard let firstIndex = indices.first else {
            // Indicating an empty collection
            return
        }

        for (offset, element) in enumerated() where predicate(element) {
            let index = indices.index(firstIndex, offsetBy: offset)
            var copy = element
            try block(&copy)
            self[index] = copy
        }
    }

    public mutating func changeElements(byEquality element: Element, using block: (inout Element) throws -> Void) rethrows where Element: Equatable {
        try changeElements(where: { $0 == element }, using: block)
    }

    public mutating func changeElements(byHashValue element: Element, using block: (inout Element) throws -> Void) rethrows where Element: Hashable {
        try changeElements(where: { $0.hashValue == element.hashValue }, using: block)
    }

    public mutating func changeElements(bySpecs specs: ChangeSpec<Element>...) {
        guard let firstIndex = indices.first else { return }

        for spec in specs {
            for (offset, element) in enumerated() where spec.shouldChange(element) {
                let index = indices.index(firstIndex, offsetBy: offset)
                if let result = spec.changed(element) {
                    self[index] = result
                }
            }
        }
    }
}

public struct ChangeSpec<Element> {
    private let predicate: (Element) -> Bool
    private let block: (inout Element) throws -> Void

    public init(predicate: @escaping (Element) -> Bool, block: @escaping (inout Element) throws -> Void) {
        self.predicate = predicate
        self.block = block
    }

    public func shouldChange(_ element: Element) -> Bool {
        return predicate(element)
    }

    public func changed(_ element: Element) -> Element? {
        do {
            var copy = element
            try block(&copy)
            return copy
        }
        catch {
            return nil
        }
    }
}
