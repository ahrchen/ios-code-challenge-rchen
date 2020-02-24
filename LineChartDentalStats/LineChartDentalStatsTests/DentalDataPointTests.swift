//
//  DentalDataPointTests.swift
//  LineChartDentalStats
//
//  Created by Raymond Chen on 2/23/20.
//  Copyright © 2020 Raymond Chen. All rights reserved.
//

import XCTest
@testable import LineChartDentalStats

class DentalDataPointTests: XCTestCase {

    func testDecodingWhenMissingTimeStampItThrows() throws{
        AssertThrowsKeyNotFound("t", decoding: DentalDataPoint.self, from: try fixture.json(deletingKeyPaths: "t"))
    }

    func testDecodingWhenMissingNumPeopleItThrows() throws{
        AssertThrowsKeyNotFound("y", decoding: DentalDataPoint.self, from: try fixture.json(deletingKeyPaths: "y"))
    }

    let fixture = Data("""
    {
        "t": 1579294990,
        "y": 1
    }
    """.utf8)

    func AssertThrowsKeyNotFound<T: Decodable>(_ expectedKey: String, decoding: T.Type, from data: Data, file: StaticString = #file, line: UInt = #line) {
        XCTAssertThrowsError(try JSONDecoder().decode(decoding, from: data), file: file, line: line) { error in
            if case .keyNotFound(let key, _)? = error as? DecodingError {
                XCTAssertEqual(expectedKey, key.stringValue, "Expected missing key '\(key.stringValue)' to equal '\(expectedKey)'.", file: file, line: line)
            } else {
                XCTFail("Expected '.keyNotFound(\(expectedKey))' but got \(error)", file: file, line: line)
            }
        }
    }
}

extension Data {
    func json(deletingKeyPaths keyPaths: String...) throws -> Data {
        let decoded = try JSONSerialization.jsonObject(with: self, options: .mutableContainers) as AnyObject

        for keyPath in keyPaths {
            decoded.setValue(nil, forKeyPath: keyPath)
        }

        return try JSONSerialization.data(withJSONObject: decoded)
    }
}
