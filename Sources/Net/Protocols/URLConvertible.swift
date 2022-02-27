import Foundation

/// Represents a value that can be transformed into a URL
public protocol URLConvertible {
    
    var url: URL? { get }
}

extension String: URLConvertible {
    
    public var url: URL? { URL(string: self) }
}

extension URL: URLConvertible {
    
    public var url: URL? { self }
}
