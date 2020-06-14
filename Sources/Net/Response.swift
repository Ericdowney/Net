import Foundation

public struct Response<Value: Codable> {
    
    public var value: Value
    public var response: URLResponse
}
