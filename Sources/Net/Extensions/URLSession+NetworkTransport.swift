import Foundation
import Combine

extension URLSession: NetworkTransport {
    
    /// Sends the specified `Request` object via a `URLRequest`
    /// - Returns: Raw response data and `URLResponse` publisher
    public func send(_ request: Request) -> AnyPublisher<Response<Data>, Error> {
        do {
            return dataTaskPublisher(for: try request.toUrlRequest())
                .tryMap { Response(value: $0.data, response: $0.response) }
                .eraseToAnyPublisher()
        } catch {
            return Future.failure(error)
                .eraseToAnyPublisher()
        }
    }
    
    /// Sends the specified `Request` object via a `URLRequest`
    /// - Returns: Decoded response value and `URLResponse` publisher
    public func send<ResponseValue>(_ request: Request) -> AnyPublisher<Response<ResponseValue>, Error> where ResponseValue : Codable {
        send(request)
            .tryMap { Response(value: try JSONDecoder().decode(ResponseValue.self, from: $0.value), response: $0.response) }
            .eraseToAnyPublisher()
    }
    
    @available(iOS 15.0, *)
    public func send(_ request: Request) async throws -> Response<Data> {
        let response = try await data(for: request.toUrlRequest(), delegate: nil)
        return Response(value: response.0, response: response.1)
    }
    
    @available(iOS 15.0, *)
    public func send<ResponseValue>(_ request: Request) async throws -> Response<ResponseValue> where ResponseValue: Codable {
        let response = try await send(request)
        return Response(value: try JSONDecoder().decode(ResponseValue.self, from: response.value),
                        response: response.response)
    }
}
