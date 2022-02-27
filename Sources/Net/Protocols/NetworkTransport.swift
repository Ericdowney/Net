import Foundation
import Combine

public protocol NetworkTransport {
    
    func send(_ request: Request) -> AnyPublisher<Response<Data>, Error>
    func send<ResponseValue>(_ request: Request) -> AnyPublisher<Response<ResponseValue>, Error> where ResponseValue: Codable
    
    @available(iOS 15.0, *)
    func send(_ request: Request) async throws -> Response<Data>
    
    @available(iOS 15.0, *)
    func send<ResponseValue>(_ request: Request) async throws -> Response<ResponseValue> where ResponseValue: Codable
}
