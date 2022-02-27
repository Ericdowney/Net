import Foundation

/// A decoded response from a network request. Expects the specified value to conform to Codable.
public struct Response<Value: Codable> {
    
    public var value: Value
    public var response: URLResponse
}
