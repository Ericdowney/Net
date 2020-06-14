import XCTest
@testable import Net

final class AnyEncodableTests: XCTestCase {
    
    // MARK: - Tests
    
    func test_encode_shouldEncodeObject() throws {
        let subject = AnyEncodable(["Hello": "World"])
        
        let data = try JSONEncoder().encode(subject)
        
        XCTAssertNotNil(data)
    }
    
    // MARK: - Test Registration
    
    static var allTests = [
        ("test_encode_shouldEncodeObject", test_encode_shouldEncodeObject)
    ]
}
