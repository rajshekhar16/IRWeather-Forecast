//
//  Forecast5Response.swift
//  IRWeather Forecast
//
//  Created by Rajshekhar on 16/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import Foundation

struct Forecast5Response: Decodable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [ListData]
    let city: CityData
}

struct ListData: Decodable {
    let dt: Double
    let main: MainListData
    let weather: [WeatherData]
    let wind: WindData
    let dtTxt: String
}

struct MainListData: Decodable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let humidity: Int
}

struct WeatherData: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WindData: Decodable {
    let speed: Double
    let deg: Int
}

struct CityData: Decodable {
    let id: Double
    let name: String
    let coord: CoordinateData
    let country: String
    let timezone: Double
    let sunrise: Double
    let sunset: Double
}

struct CoordinateData: Decodable {
    let lat: Double
    let lon: Double
}

struct ForecastPresentableData {
    var shortDate: String?
    var day: String?
    var time: String?
    var temp: String
    var humidity: String
    var weather: String
    var weatherImgUrl: String
    var windSpeed: String
}
