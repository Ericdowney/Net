import XCTest

import NetTests

var tests = [XCTestCaseEntry]()
tests += AnyEncodable.allTests()
XCTMain(tests)
