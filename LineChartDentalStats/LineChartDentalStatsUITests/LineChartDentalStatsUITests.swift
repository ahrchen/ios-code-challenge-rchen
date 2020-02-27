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

    func testUI() {
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
        let isDentalStatsDisplaying = app.otherElements["Dental Statistics"].firstMatch.exists
        let isChartViewDisplaying = app.otherElements["Line Chart View"].firstMatch.exists
        let isPreviousButtonDisplaying = app.buttons["Previous Button"].firstMatch.exists
        let isNextButtonDisplaying = app.buttons["Next Button"].firstMatch.exists
        let isTitleLabelDisplaying = app.staticTexts["Title Label"].firstMatch.exists
        let isTimeLabelDisplaying = app.staticTexts["Time Label"].firstMatch.exists
        XCTAssert(isDentalStatsDisplaying)
        XCTAssert(isChartViewDisplaying)
        XCTAssert(isPreviousButtonDisplaying)
        XCTAssert(isNextButtonDisplaying)
        XCTAssert(isTitleLabelDisplaying)
        XCTAssert(isTimeLabelDisplaying)
        app.terminate()
    }

}
