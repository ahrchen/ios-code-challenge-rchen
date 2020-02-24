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

    func testDecodingWhenMissingTimeStampItThrows() {
        XCTAssertThrowsError(try JSONDecoder().decode(DentalDataPoint.self, from: dataPointMissingTimeStamp)) { error in
            if case .keyNotFound(let key, _)? = error as? DecodingError {
                XCTAssertEqual("t", key.stringValue)
            } else {
                XCTFail("Expected '.keyNotFound' but got \(error)")
            }
        }
    }

    func testDecodingWhenMissingNumPeopleItThrows() {
        XCTAssertThrowsError(try JSONDecoder().decode(DentalDataPoint.self, from: dataPointMissingNumPeople)) { error in
            if case .keyNotFound(let key, _)? = error as? DecodingError {
                XCTAssertEqual("y", key.stringValue)
            } else {
                XCTFail("Expected '.keyNotFound' but got \(error)")
            }
        }
    }

    let dataPointMissingTimeStamp = Data("""
    {
        "y": 1
    }
    """.utf8)

    let dataPointMissingNumPeople = Data("""
    {
        "t": 1579294990,
    }
    """.utf8)



}
