//
//  ForecastServiceMock.swift
//  IRWeather ForecastTests
//
//  Created by Rajshekhar on 17/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import Foundation
@testable import IRWeather_Forecast

class ForecastServiceMock {
    var shouldReturnError = false
    var apiWasCalled = false

    func reset() {
        shouldReturnError = false
        apiWasCalled = false
    }

    convenience init() {
        self.init(false)
    }

    init(_ shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
}

extension ForecastServiceMock: ForecastServiceProtocol {
    func fetchForecastDataForFiveDays(completionHandler: @escaping (Forecast5Response?, String?) -> Void) {
        apiWasCalled = true
        if shouldReturnError {
            completionHandler(nil, "Error in fetching data")
        } else {
            if let dataConversionObj = DataConversion(fileName: "Forecast5Mock", fileExtension: "json") {
                let data = dataConversionObj.getDataFromFile()
                let forecastResponse: Forecast5Response? = try? dataConversionObj.decodeData(data: data)
                completionHandler(forecastResponse, nil)
            }
        }
    }
}
