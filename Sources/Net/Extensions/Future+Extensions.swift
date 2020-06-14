import Foundation
import Combine

extension Future {
    
    static func success(_ value: Output) -> Future<Output, Failure> {
        Future { $0(.success(value)) }
    }
    
    static func failure(_ value: Failure) -> Future<Output, Failure> {
        Future { $0(.failure(value)) }
    }
}

