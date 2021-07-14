import Foundation

@propertyWrapper
public struct UserDefaultsWrapper<Type> {
    public var wrappedValue: Type? {
        get {
            if let value = userDefaults.object(forKey: key) as? Type {
                return value
            }
            return defaultValue
        }
        set {
            userDefaults.set(newValue, forKey: key)
        }
    }

    public init(key: String, in userDefaults: UserDefaults = .standard, defaultValue: Type? = nil) {
        self.key = key
        self.userDefaults = userDefaults
        self.defaultValue = defaultValue
    }

    private let key: String
    private let userDefaults: UserDefaults
    private let defaultValue: Type?
}
