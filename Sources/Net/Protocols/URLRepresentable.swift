import Foundation

public protocol URLRepresentable {
    var url: URL? { get }
}

extension String: URLRepresentable {
    
    public var url: URL? { URL(string: self) }
}

extension URL: URLRepresentable {
    
    public var url: URL? { self }
}
