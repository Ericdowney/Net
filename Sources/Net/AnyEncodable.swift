import Foundation

/// Type erased value that can be encoded into data
public struct AnyEncodable: Encodable {
    
    // MARK: - Properties
    
    private let _encode: (Encoder) throws -> Void
    
    // MARK: - Lifecycle
    
    /// Initializes an `AnyEncodable` object wrapping the specified `Encodable` object
    public init<T: Encodable>(_ wrapped: T) {
        self._encode = wrapped.encode
    }
    
    // MARK: - Methods
    
    /// Encodes object into specified `Encoder`
    /// - Parameter encoder: The `Encoder` to use for encoding values
    public func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}
