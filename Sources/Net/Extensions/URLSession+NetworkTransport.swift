import Foundation
import Combine

public enum NetErrors: Error {
    case invalidURL, invalidResponse
}

extension URLSession: NetworkTransport {
    
    public func send<ResponseValue>(_ request: Request) -> AnyPublisher<Response<ResponseValue>, Error> where ResponseValue : Decodable, ResponseValue : Encodable {
        guard let request = request.urlRequest else { return Future.failure(NetErrors.invalidURL).eraseToAnyPublisher() }
        
        return dataTaskPublisher(for: request).tryMap {
            Response(value: try JSONDecoder().decode(ResponseValue.self, from: $0.data),
                     response: $0.response)
        }.eraseToAnyPublisher()
    }
}
