//
//  WeatherEndpoints.swift
//  IRWeather Forecast
//
//  Created by Rajshekhar on 16/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import Foundation

enum Secrets {
    static let appID = "cbba9042ec2fa0e8c10b94bcecc4e58b"
}

enum WeatherEndPoints: Endpoint {

    case getFiveDaysForecast(cityName: String)
    case getForecastOfCities(cityIDs: [String])

    var scheme: String {
        switch self {
        case .getForecastOfCities, .getFiveDaysForecast:
            return "https"
        }
    }

    var baseURL: String {
        switch self {
        case .getForecastOfCities, .getFiveDaysForecast:
            return "api.openweathermap.org"
        }
    }

    var path: String {
        switch self {
        case .getFiveDaysForecast:
            return "/data/2.5/forecast"
        case .getForecastOfCities:
            return "/data/2.5/group"
        }
    }

    var parameters: [URLQueryItem] {
        switch self {
        case .getFiveDaysForecast(let cityName):
            return [URLQueryItem(name: "q", value: cityName),
                    URLQueryItem(name: "appid", value: Secrets.appID)
            ]
        case .getForecastOfCities(let cityIDs):
            let cityIDs = cityIDs.joined(separator: ",")
            return [URLQueryItem(name: "id", value: cityIDs),
                    URLQueryItem(name: "appid", value: Secrets.appID)
            ]
        }
    }

    var method: HttpMethod {
        switch self {
        case .getFiveDaysForecast, .getForecastOfCities:
            return .GET
        }
    }

}
