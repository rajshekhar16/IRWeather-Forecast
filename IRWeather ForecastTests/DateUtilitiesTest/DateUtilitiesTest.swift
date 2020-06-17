//
//  DateUtilitiesTest.swift
//  IRWeather ForecastTests
//
//  Created by Rajshekhar on 17/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import XCTest
@testable import IRWeather_Forecast

class DateUtilitiesTest: XCTestCase {

    var sut: DateUtilities!

    override func setUp() {
        super.setUp()
        sut = DateUtilities(dateInDouble: 1592374714)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testDate_iscurrentDay_correct() {
        let day = sut.day
        XCTAssertEqual(day, "Wednesday")
        XCTAssertNotEqual(day, "Thursday")
    }

    func testDate_isShortDate_correct() {
        let shortDate = sut.shortDate
        XCTAssertEqual(shortDate, "June 17")
    }

    func testDate_isCurrentTime_correct() {
        let currentTime = sut.time
        XCTAssertEqual(currentTime, "11:48 AM")
    }



}
