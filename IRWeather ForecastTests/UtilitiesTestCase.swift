//
//  UtilitiesTestCase.swift
//  IRWeather ForecastTests
//
//  Created by Rajshekhar on 17/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import XCTest
@testable import IRWeather_Forecast

class UtilitiesTestCase: XCTestCase {
      var sut: DataConversion!

    override func setUp() {
        super.setUp()
        sut = DataConversion(fileName: "Forecast5Mock", fileExtension: "json")
    }

      override func tearDown() {
          sut = nil
          super.tearDown()
      }

    func test_dataConversionObj_created() {
        XCTAssertNotNil(sut)
    }

    func test_dataConversionInit_failedwithwrongfilename() {
        sut = DataConversion(fileName: "Forecast5Mockss", fileExtension: "json")
        XCTAssertNil(sut)
    }

    func test_dataFromFile_correct() {
        let data = sut.getDataFromFile()
        XCTAssertNotNil(data)
    }

    func test_getObjectFromData_correct() {
        XCTAssertNotNil(sut)
        let data = sut.getDataFromFile()
        let obj: Forecast5Response? = try? sut.decodeData(data: data)
        XCTAssertNotNil(obj)

    }
}
