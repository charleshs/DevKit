import Foundation

extension Dictionary {
    /// Encodes the dictionary with serializable values into JSON-formatted data.
    ///
    /// - Returns: The encoded result with JSON format. Returns `nil` if it contains unserializable values.
    public func jsonSafeEncodedData(options: JSONSerialization.WritingOptions = .fragmentsAllowed) -> Data? {
        guard JSONSerialization.isValidJSONObject(self) else {
            print("\(self) is not a valid JSON object!")
            return nil
        }
        
        return try? JSONSerialization.data(withJSONObject: self, options: options)
    }

    /// Encodes the dictionary into JSON-formatted data.
    ///
    /// - Returns: The encoded result with JSON format. Returns `nil` when the serialization fails.
    public func jsonEncodedData(options: JSONSerialization.WritingOptions = .fragmentsAllowed) -> Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: options)
    }
}
