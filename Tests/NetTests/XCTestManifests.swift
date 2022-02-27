import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AnyEncodableTests.allTests),
        testCase(RequestTests.allTests),
    ]
}
#endif
