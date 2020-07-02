//
//  CitiesForecastServiceMock.swift
//  IRWeather ForecastTests
//
//  Created by Rajshekhar on 18/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import Foundation
@testable import IRWeather_Forecast

class CitiesForecastServiceMock {
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

extension CitiesForecastServiceMock: CitiesServiceProtocol {
    func fetchForecastForMultipleCities(completionHandler: @escaping (CitiesForecastResponse?, String?) -> Void) {
        apiWasCalled = true
        if shouldReturnError {
            completionHandler(nil, "Error in fetching data")
        } else {
            if let dataConversionObj = DataConversion(fileName: "CitiesForecastResponseMock", fileExtension: "json") {
                let data = dataConversionObj.getDataFromFile()
                let forecastResponse: CitiesForecastResponse? = try? dataConversionObj.decodeData(data: data)
                completionHandler(forecastResponse, nil)
            }
        }
    }
}
