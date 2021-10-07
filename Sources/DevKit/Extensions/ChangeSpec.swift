import Foundation

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
