import Foundation

/// Object containing information to make an network request. Includes url, headers, HTTP method, and body.
public struct Request {
    public typealias Headers = [String: String]
    
    /// Represents the HTTP methods for making network requests.
    public enum Method: String {
        case get, post, put, delete, patch, head, options
    }
    
    /// Wrapper for network request body data. Can take the form of JSON, raw data, or empty.
    public enum Body: ExpressibleByNilLiteral {
        case json(AnyEncodable), data(Data), none
        
        public init(nilLiteral: ()) { self = .none }
    }
    
    // MARK: - Properties
    
    var urlConvertible: URLConvertible
    var method: Self.Method
    var headers: Headers?
    var body: Body
    
    // MARK: - Lifecycle
    
    /// Initializes a Request object with the specified parameters
    /// - Parameters:
    ///   - url: URL to make the request
    ///   - method: HTTP method, i.e. GET, PUT, POST, etc.
    ///   - headers: Request headers to attach to network request or nil
    ///   - body: Data for request or nil
    public init(url: URLConvertible,
                method: Self.Method,
                headers: Headers? = nil,
                body: Self.Body = nil) {
        self.urlConvertible = url
        self.method = method
        self.headers = headers
        self.body = body
    }
    
    // MARK: - Methods
    
    /// Initializes a GET request with the specified URL and headers
    /// - Parameters:
    ///   - url: URL to make the GET request
    ///   - headers: Request headers to attach to network request or nil
    ///   - body: Data for request or nil
    /// - Returns: Initiailized Request object with specified parameters
    public static func get(_ url: URLConvertible, headers: Headers? = nil, body: Self.Body = nil) -> Request {
        .init(url: url, method: .get, headers: headers, body: nil)
    }
    
    /// Initializes a POST request with the specified URL and headers
    /// - Parameters:
    ///   - url: URL to make the POST request
    ///   - headers: Request headers to attach to network request or nil
    ///   - body: Data for request or nil
    /// - Returns: Initiailized Request object with specified parameters
    public static func post(_ url: URLConvertible, headers: Headers? = nil, body: Self.Body = nil) -> Request {
        .init(url: url, method: .post, headers: headers, body: body)
    }
    
    /// Initializes a PUT request with the specified URL and headers
    /// - Parameters:
    ///   - url: URL to make the PUT request
    ///   - headers: Request headers to attach to network request or nil
    ///   - body: Data for request or nil
    /// - Returns: Initiailized Request object with specified parameters
    public static func put(_ url: URLConvertible, headers: Headers? = nil, body: Self.Body = nil) -> Request {
        .init(url: url, method: .put, headers: headers, body: body)
    }
    
    /// Initializes a PATCH request with the specified URL and headers
    /// - Parameters:
    ///   - url: URL to make the PATCH request
    ///   - headers: Request headers to attach to network request or nil
    ///   - body: Data for request or nil
    /// - Returns: Initiailized Request object with specified parameters
    public static func patch(_ url: URLConvertible, headers: Headers? = nil, body: Self.Body = nil) -> Request {
        .init(url: url, method: .patch, headers: headers, body: body)
    }
    
    /// Initializes a DELETE request with the specified URL and headers
    /// - Parameters:
    ///   - url: URL to make the DELETE request
    ///   - headers: Request headers to attach to network request or nil
    ///   - body: Data for request or nil
    /// - Returns: Initiailized Request object with specified parameters
    public static func delete(_ url: URLConvertible, headers: Headers? = nil, body: Self.Body = nil) -> Request {
        .init(url: url, method: .delete, headers: headers, body: body)
    }
    
    
    /// Initializes a HEAD request with the specified URL and headers
    /// - Parameters:
    ///   - url: URL to make the HEAD request
    ///   - headers: Request headers to attach to network request or nil
    ///   - body: Data for request or nil
    /// - Returns: Initiailized Request object with specified parameters
    public static func head(_ url: URLConvertible, headers: Headers? = nil, body: Self.Body = nil) -> Request {
        .init(url: url, method: .head, headers: headers, body: nil)
    }
    
    /// Initializes a OPTIONS request with the specified URL and headers
    /// - Parameters:
    ///   - url: URL to make the OPTIONS request
    ///   - headers: Request headers to attach to network request or nil
    ///   - body: Data for request or nil
    /// - Returns: Initiailized Request object with specified parameters
    public static func options(_ url: URLConvertible, headers: Headers? = nil, body: Self.Body = nil) -> Request {
        .init(url: url, method: .options, headers: headers, body: nil)
    }
    
    /// Transforms the `Request` object into a URLRequest to be used in conjection with a URLSession.
    /// - Returns: URLRequest containing all data from original Request object.
    func toUrlRequest() throws -> URLRequest {
        guard let url = urlConvertible.url else { throw NetErrors.invalidURL }
        
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
}
