import Foundation
import Combine

public protocol NetworkTransport {
    func send<ResponseValue: Codable>(_ request: Net.Request) -> AnyPublisher<Net.Response<ResponseValue>, Error>
}
