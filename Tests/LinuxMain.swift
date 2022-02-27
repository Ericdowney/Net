import XCTest

import NetTests

var tests = [XCTestCaseEntry]()
tests += AnyEncodable.allTests()
tests += RequestTests.allTests()
XCTMain(tests)
