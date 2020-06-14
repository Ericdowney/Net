import Foundation

public struct AnyEncodable: Encodable {
    
    // MARK: - Properties
    
    private let _encode: (Encoder) throws -> Void
    
    // MARK: - Lifecycle
    
    public init<T: Encodable>(_ wrapped: T) {
        self._encode = wrapped.encode
    }
    
    // MARK: - Methods
    
    public func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}
