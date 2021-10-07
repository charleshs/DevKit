import Foundation

extension Data {
    public func jsonDecodedDictionary(options: JSONSerialization.ReadingOptions = .allowFragments) -> [String: Any] {
        return (try? JSONSerialization.jsonObject(with: self, options: options) as? [String: Any]) ?? [:]
    }

    public func jsonDecodedObject<T: Decodable>(ofType: T.Type = T.self, decoder: JSONDecoder = JSONDecoder()) throws -> T {
        try decoder.decode(T.self, from: self)
    }

    public func plistDecodedObject<T: Decodable>(ofType: T.Type = T.self, decoder: PropertyListDecoder = PropertyListDecoder()) throws -> T {
        try decoder.decode(T.self, from: self)
    }
}
