//
//  CityModel.swift
//  IRWeather Forecast
//
//  Created by Rajshekhar on 16/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import Foundation

struct CityModel: Decodable {
    var id: Int
    var name: String
    var country: String
}
