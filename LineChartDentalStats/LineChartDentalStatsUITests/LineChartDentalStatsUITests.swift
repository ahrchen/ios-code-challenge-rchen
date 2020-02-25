//
//  LineChartDentalStatsUITests.swift
//  LineChartDentalStatsUITests
//
//  Created by Raymond Chen on 2/25/20.
//  Copyright © 2020 Raymond Chen. All rights reserved.
//

import XCTest
@testable import LineChartDentalStats

class LineChartDentalStatsUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }

    func testButtons() {
        let app = XCUIApplication()
        app.launch()
        let isDisplayingDentalStats = app.otherElements["Dental Statistics"].exists
        XCTAssert(isDisplayingDentalStats)
        app.buttons["Previous Button"].tap()
        app.buttons["Next Button"].tap()
    }

}
