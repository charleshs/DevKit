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
    public mutating func changeElements(where predicate: (Element) -> Bool, mutation: (inout Element) throws -> Void) rethrows {
        try _changeElements(predicate: predicate, mutation: mutation)
    }

    public mutating func changeElements(byEquality element: Element, mutation: (inout Element) throws -> Void) rethrows where Element: Equatable {
        try _changeElements(predicate: { $0 == element }, mutation: mutation)
    }

    public mutating func changeElements(byHashValue element: Element, mutation: (inout Element) throws -> Void) rethrows where Element: Hashable {
        try _changeElements(predicate: { $0.hashValue == element.hashValue }, mutation: mutation)
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

    fileprivate mutating func _changeElements(predicate: (Element) -> Bool, mutation: (inout Element) throws -> Void) rethrows {
        guard let firstIndex = indices.first else {
            // Indicating an empty collection
            return
        }

        for (offset, element) in enumerated() where predicate(element) {
            let index = indices.index(firstIndex, offsetBy: offset)
            var copy = element
            try mutation(&copy)
            self[index] = copy
        }
    }
}

public struct ChangeSpec<Element> {
    private let predicate: (Element) -> Bool
    private let mutation: (inout Element) throws -> Void

    public init(predicate: @escaping (Element) -> Bool, mutation: @escaping (inout Element) throws -> Void) {
        self.predicate = predicate
        self.mutation = mutation
    }

    func shouldChange(_ element: Element) -> Bool {
        return predicate(element)
    }

    func changed(_ element: Element) -> Element? {
        do {
            var copy = element
            try mutation(&copy)
            return copy
        }
        catch {
            return nil
        }
    }
}
