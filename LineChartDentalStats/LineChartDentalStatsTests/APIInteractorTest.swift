//
//  APIInteractorTest.swift
//  LineChartDentalStatsTests
//
//  Created by Raymond Chen on 2/26/20.
//  Copyright © 2020 Raymond Chen. All rights reserved.
//

import XCTest
import OHHTTPStubs
import Alamofire
@testable import LineChartDentalStats

class APIInteractorTest: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testfetchLineChartData() {

        let apiInteractor = APIInteractor()

        let promise = expectation(description: "Simple Request")

        let urlString1 = "https://raw.githubusercontent.com/rune-labs/ios-code-challenge-rchen/master/api/1.json"

        stub(condition: isPath(urlString1)) { request in
                    let stubPath = OHPathForFile("1.json", type(of: self))
                    return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
                }
        
        apiInteractor.fetchLineChartData(page: 1) { dentalDataPoints in
            guard let dentalDataPoints = dentalDataPoints else { return }
            XCTAssertEqual(dentalDataPoints[0].time, Date(timeIntervalSince1970: 1579294990))
            XCTAssertEqual(dentalDataPoints[0].numberOfPeopleBrushingTeeth, 1)
            promise.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
