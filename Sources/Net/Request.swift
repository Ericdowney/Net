import Foundation

public struct Request {
    public typealias Headers = [String: String]
    public enum Method: String {
        case get, post, put, delete, patch, head, options
    }
    public enum Body: ExpressibleByNilLiteral {
        case json(AnyEncodable), data(Data), none
        
        public init(nilLiteral: ()) { self = .none }
    }
    
    // MARK: - Properties
    
    public var urlRequest: URLRequest? {
        guard let url = urlConvertible.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpMethod = method.rawValue.uppercased()
        urlRequest.httpBody = {
            switch body {
            case .data(let value): return value
            case .json(let value): return try? JSONEncoder().encode(value)
            case .none: return nil
            }
        }()
        return urlRequest
    }
    
    var urlConvertible: URLRepresentable
    var method: Self.Method
    var headers: Headers?
    var body: Body
    
    // MARK: - Lifecycle
    
    public init(url: URLRepresentable,
                method: Self.Method,
                headers: Headers? = nil,
                body: Self.Body = nil) {
        self.urlConvertible = url
        self.method = method
        self.headers = headers
        self.body = body
    }
    
    // MARK: - Methods
    
    public static func get(_ url: URLRepresentable, headers: Headers? = nil) -> Request {
        .init(url: url, method: .get, headers: headers, body: nil)
    }
    
    public static func post(_ url: URLRepresentable, headers: Headers? = nil, body: Self.Body = nil) -> Request {
        .init(url: url, method: .post, headers: headers, body: body)
    }
    
    public static func put(_ url: URLRepresentable, headers: Headers? = nil, body: Self.Body = nil) -> Request {
        .init(url: url, method: .put, headers: headers, body: body)
    }
    
    public static func delete(_ url: URLRepresentable, headers: Headers? = nil, body: Self.Body = nil) -> Request {
        .init(url: url, method: .delete, headers: headers, body: body)
    }
    
    public static func patch(_ url: URLRepresentable, headers: Headers? = nil, body: Self.Body = nil) -> Request {
        .init(url: url, method: .patch, headers: headers, body: body)
    }
    
    public static func head(_ url: URLRepresentable, headers: Headers? = nil) -> Request {
        .init(url: url, method: .head, headers: headers, body: nil)
    }
    
    public static func options(_ url: URLRepresentable, headers: Headers? = nil) -> Request {
        .init(url: url, method: .options, headers: headers, body: nil)
    }
}
