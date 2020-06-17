//
//  CitiesForecastResponse.swift
//  IRWeather Forecast
//
//  Created by Rajshekhar on 17/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import Foundation

struct CitiesForecastResponse: Decodable {
    var cnt: Int
    var list: [CitiesList]
}

struct CitiesList: Decodable {
    var weather: [WeatherData]
    var main: MainListData
    var name: String
    var wind: WindData
}
