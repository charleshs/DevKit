import Foundation

@propertyWrapper
public struct StoredInUserDefaults<Value> {
    public var wrappedValue: Value? {
        get {
            if let value = userDefaults.object(forKey: key) as? Value {
                return value
            }
            return defaultValue
        }
        set {
            userDefaults.set(newValue, forKey: key)
        }
    }

    public init(key: String, in userDefaults: UserDefaults = .standard, defaultValue: Value? = nil) {
        self.key = key
        self.userDefaults = userDefaults
        self.defaultValue = defaultValue
    }

    private let key: String
    private let userDefaults: UserDefaults
    private let defaultValue: Value?
}
