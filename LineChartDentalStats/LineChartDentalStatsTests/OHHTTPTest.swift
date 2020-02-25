//
//  OHHTTPTest.swift
//  LineChartDentalStatsTests
//
//  Created by Raymond Chen on 2/24/20.
//  Copyright © 2020 Raymond Chen. All rights reserved.
//

import XCTest
import OHHTTPStubs
import Alamofire
@testable import LineChartDentalStats

class OHHTTPTest: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testStubWithOHHTTPStub() {
        guard let gitURL = URL(string: "https://raw.githubusercontent.com/rune-labs/ios-code-challenge-rchen/master/api/1.json") else { return }
        let promise = expectation(description: "Simple Request")

        stub(condition: isPath("https://raw.githubusercontent.com/rune-labs/ios-code-challenge-rchen/master/api/1.json")) { request in
                    let stubPath = OHPathForFile("1.json", type(of: self))
                    return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
                }

        AF.request(gitURL).validate().responseDecodable(of: Array<DentalDataPoint>.self) { (response) in
                guard let dentalDataPoints = response.value else { return }
                XCTAssertEqual(dentalDataPoints[0].time, Date(timeIntervalSince1970: 1579294990))
                XCTAssertEqual(dentalDataPoints[0].numberOfPeopleBrushingTeeth, 1)
                promise.fulfill()
            }
        waitForExpectations(timeout: 5, handler: nil)
    }

}
