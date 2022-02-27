import XCTest
@testable import Net

final class RequestTests: XCTestCase {
    
    // MARK: - Tests
    
    func test_init_shouldInitializeRequestObject() {
        let subject = Request(url: URL(string: "https://google.com")!, method: .get, headers: ["a": "b"], body: .json(.init(["test": "data"])))
        
        XCTAssertEqual(subject.urlConvertible.url?.absoluteString, "https://google.com")
        XCTAssertEqual(subject.method, .get)
        XCTAssertEqual(subject.headers, ["a": "b"])
        switch subject.body {
        case .json(let value): XCTAssertNotNil(value)
        default: XCTFail()
        }
    }
    
    func test_get_shouldInitializeRequestObject() {
        let subject = Request.get("https://google.com", headers: ["a": "b"])
        
        XCTAssertEqual(subject.urlConvertible.url?.absoluteString, "https://google.com")
        XCTAssertEqual(subject.method, .get)
        XCTAssertEqual(subject.headers, ["a": "b"])
        switch subject.body {
        case .none: XCTAssertEqual(1, 1)
        default: XCTFail()
        }
    }
    
    func test_post_shouldInitializeRequestObject() {
        let subject = Request.post("https://google.com", headers: ["a": "b"], body: .json(.init(["test": "data"])))
        
        XCTAssertEqual(subject.urlConvertible.url?.absoluteString, "https://google.com")
        XCTAssertEqual(subject.method, .post)
        XCTAssertEqual(subject.headers, ["a": "b"])
        switch subject.body {
        case .json(let value): XCTAssertNotNil(value)
        default: XCTFail()
        }
    }
    
    func test_put_shouldInitializeRequestObject() {
        let subject = Request.put("https://google.com", headers: ["a": "b"], body: .json(.init(["test": "data"])))
        
        XCTAssertEqual(subject.urlConvertible.url?.absoluteString, "https://google.com")
        XCTAssertEqual(subject.method, .put)
        XCTAssertEqual(subject.headers, ["a": "b"])
        switch subject.body {
        case .json(let value): XCTAssertNotNil(value)
        default: XCTFail()
        }
    }
    
    func test_delete_shouldInitializeRequestObject() {
        let subject = Request.delete("https://google.com", headers: ["a": "b"], body: .json(.init(["test": "data"])))
        
        XCTAssertEqual(subject.urlConvertible.url?.absoluteString, "https://google.com")
        XCTAssertEqual(subject.method, .delete)
        XCTAssertEqual(subject.headers, ["a": "b"])
        switch subject.body {
        case .json(let value): XCTAssertNotNil(value)
        default: XCTFail()
        }
    }
    
    func test_patch_shouldInitializeRequestObject() {
        let subject = Request.patch("https://google.com", headers: ["a": "b"], body: .json(.init(["test": "data"])))
        
        XCTAssertEqual(subject.urlConvertible.url?.absoluteString, "https://google.com")
        XCTAssertEqual(subject.method, .patch)
        XCTAssertEqual(subject.headers, ["a": "b"])
        switch subject.body {
        case .json(let value): XCTAssertNotNil(value)
        default: XCTFail()
        }
    }
    
    func test_head_shouldInitializeRequestObject() {
        let subject = Request.head("https://google.com", headers: ["a": "b"])
        
        XCTAssertEqual(subject.urlConvertible.url?.absoluteString, "https://google.com")
        XCTAssertEqual(subject.method, .head)
        XCTAssertEqual(subject.headers, ["a": "b"])
        switch subject.body {
        case .none: XCTAssertEqual(1, 1)
        default: XCTFail()
        }
    }
    
    func test_options_shouldInitializeRequestObject() {
        let subject = Request.options("https://google.com", headers: ["a": "b"])
        
        XCTAssertEqual(subject.urlConvertible.url?.absoluteString, "https://google.com")
        XCTAssertEqual(subject.method, .options)
        XCTAssertEqual(subject.headers, ["a": "b"])
        switch subject.body {
        case .none: XCTAssertEqual(1, 1)
        default: XCTFail()
        }
    }
    
    func test_toURLRequest_shouldInitializeURLRequestObject() throws {
        let subject = Request.get("https://google.com", headers: ["a": "b"])
        
        let result = try subject.toUrlRequest()
        
        XCTAssertEqual(result.url?.absoluteString, "https://google.com")
        XCTAssertEqual(result.allHTTPHeaderFields, ["a": "b"])
        XCTAssertEqual(result.httpMethod, "GET")
        XCTAssertNil(result.httpBody)
    }
    
    // MARK: - Test Registration
    
    static var allTests = [
        ("test_init_shouldInitializeRequestObject", test_init_shouldInitializeRequestObject),
        ("test_get_shouldInitializeGetRequestObject", test_get_shouldInitializeRequestObject),
        ("test_post_shouldInitializeGetRequestObject", test_post_shouldInitializeRequestObject),
        ("test_put_shouldInitializeGetRequestObject", test_put_shouldInitializeRequestObject),
        ("test_delete_shouldInitializeGetRequestObject", test_delete_shouldInitializeRequestObject),
        ("test_patch_shouldInitializeGetRequestObject", test_patch_shouldInitializeRequestObject),
        ("test_head_shouldInitializeGetRequestObject", test_head_shouldInitializeRequestObject),
        ("test_options_shouldInitializeGetRequestObject", test_options_shouldInitializeRequestObject),
        ("test_toURLRequest_shouldInitializeURLRequestObject", test_toURLRequest_shouldInitializeURLRequestObject),
    ]
}
