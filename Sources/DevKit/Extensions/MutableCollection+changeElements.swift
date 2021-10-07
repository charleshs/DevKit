import Foundation

public extension MutableCollection {
    mutating func changeElements(
        where predicate: (Element) -> Bool,
        mutation: (inout Element) throws -> Void
    ) rethrows {
        try _changeElements(predicate: predicate, mutation: mutation)
    }

    mutating func changeElements(
        byEquality element: Element,
        mutation: (inout Element) throws -> Void
    ) rethrows where Element: Equatable {
        try _changeElements(predicate: { $0 == element }, mutation: mutation)
    }

    mutating func changeElements(
        byHashValue element: Element,
        mutation: (inout Element) throws -> Void
    ) rethrows where Element: Hashable {
        try _changeElements(predicate: { $0.hashValue == element.hashValue }, mutation: mutation)
    }

    mutating func changeElements(bySpecs specs: ChangeSpec<Element>...) {
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

    private mutating func _changeElements(
        predicate: (Element) -> Bool,
        mutation: (inout Element) throws -> Void
    ) rethrows {
        guard let firstIndex = indices.first else {
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
