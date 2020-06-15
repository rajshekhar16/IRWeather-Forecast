//
//  LocationMock.swift
//  IRWeather ForecastTests
//
//  Created by Rajshekhar on 16/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import Foundation
@testable import IRWeather_Forecast

struct UserLocationMock: UserLocation {
    var coordinate: Coordinate {
        return Coordinate(latitude: 51.509865, longitude: -0.118092)
    }
}

class UserLocationProviderMock: UserLocationProvider {

    var locationBlockLocationValue: UserLocation?
    var locationBlockErrorValue: UserLocationError?

    func findUserLocation(then: @escaping UserLocationCompletionBlock) {
        then(locationBlockLocationValue, locationBlockErrorValue)
    }
}
