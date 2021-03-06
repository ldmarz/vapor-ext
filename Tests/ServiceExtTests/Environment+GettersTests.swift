//
//  EnvironmentTests.swift
//  ServiceExt
//
//  Created by Gustavo Perdomo on 07/28/18.
//  Copyright © 2018 Vapor Community. All rights reserved.
//

@testable import ServiceExt
import XCTest

final class EnvironmentTests: XCTestCase {
    func testGetEnvAsInt() {
        setenv("VAPOR_EXT_VAR_INT", "8080", 1)

        var parsed: Int? = Environment.get("VAPOR_EXT_VAR_INT")
        XCTAssertEqual(parsed, 8080)

        parsed = Environment.get("VAPOR_EXT_VAR_______")
        XCTAssertNil(parsed)
    }

    func testGetEnvAsBool() {
        setenv("VAPOR_EXT_VAR_BOOL_1", "TRUE", 1)
        setenv("VAPOR_EXT_VAR_BOOL_2", "True", 1)
        setenv("VAPOR_EXT_VAR_BOOL_3", "true", 1)
        setenv("VAPOR_EXT_VAR_BOOL_4", "1", 1)

        setenv("VAPOR_EXT_VAR_BOOL_5", "FALSE", 1)
        setenv("VAPOR_EXT_VAR_BOOL_6", "False", 1)
        setenv("VAPOR_EXT_VAR_BOOL_7", "false", 1)
        setenv("VAPOR_EXT_VAR_BOOL_8", "0", 1)

        print("" + (Environment.get("VAPOR_EXT_VAR_BOOL_1") ?? ""))
        var parsed: Bool? = Environment.get("VAPOR_EXT_VAR_BOOL_1")
        XCTAssertEqual(parsed, true)

        parsed = Environment.get("VAPOR_EXT_VAR_BOOL_1")
        XCTAssertEqual(parsed, true)

        parsed = Environment.get("VAPOR_EXT_VAR_BOOL_2")
        XCTAssertEqual(parsed, true)

        parsed = Environment.get("VAPOR_EXT_VAR_BOOL_3")
        XCTAssertEqual(parsed, true)

        parsed = Environment.get("VAPOR_EXT_VAR_BOOL_4")
        XCTAssertEqual(parsed, true)

        parsed = Environment.get("VAPOR_EXT_VAR_BOOL_5")
        XCTAssertEqual(parsed, false)

        parsed = Environment.get("VAPOR_EXT_VAR_BOOL_6")
        XCTAssertEqual(parsed, false)

        parsed = Environment.get("VAPOR_EXT_VAR_BOOL_7")
        XCTAssertEqual(parsed, false)

        parsed = Environment.get("VAPOR_EXT_VAR_BOOL_8")
        XCTAssertEqual(parsed, false)

        parsed = Environment.get("VAPOR_EXT_VAR_BOOL_______")
        XCTAssertNil(parsed)
    }

    func testFallback() {
        setenv("VAPOR_EXT_VAR_FALLBACK", "1", 1)

        // Int
        var fallbackInt = Environment.get("VAPOR_EXT_VAR_FALLBACK", 9999)
        XCTAssertEqual(fallbackInt, 1)

        fallbackInt = Environment.get("X_____", 9999)
        XCTAssertEqual(fallbackInt, 9999)

        // Int
        var fallbackBool = Environment.get("VAPOR_EXT_VAR_FALLBACK", false)
        XCTAssertEqual(fallbackBool, true)

        fallbackBool = Environment.get("X_____", false)
        XCTAssertEqual(fallbackBool, false)

        // String
        var fallbackString = Environment.get("VAPOR_EXT_VAR_FALLBACK", "This is a test")
        XCTAssertEqual(fallbackString, "1")

        fallbackString = Environment.get("X_____", "This is a test")
        XCTAssertEqual(fallbackString, "This is a test")
    }

    func testLinuxTestSuiteIncludesAllTests() throws {
        #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
            let thisClass = type(of: self)
            let linuxCount = thisClass.allTests.count
            let darwinCount = Int(thisClass.defaultTestSuite.testCaseCount)

            XCTAssertEqual(linuxCount, darwinCount, "\(darwinCount - linuxCount) tests are missing from allTests")
        #endif
    }

    static let allTests = [
        ("testLinuxTestSuiteIncludesAllTests", testLinuxTestSuiteIncludesAllTests),
        ("testGetEnvAsInt", testGetEnvAsInt),
        ("testGetEnvAsBool", testGetEnvAsBool),
        ("testFallback", testFallback)
    ]
}
