//
//  LocationProviderMock.swift
//  IRWeather ForecastTests
//
//  Created by Rajshekhar on 16/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import Foundation
@testable import IRWeather_Forecast

class LocationProviderMock: LocationProvider {

    var isRequestWhenInUseAuthorizationCalled = false
    var isRequestLocationCalled = false

    var isUserAuthorized: Bool = false

    func requestWhenInUseAuthorization() {
        isRequestWhenInUseAuthorizationCalled = true
    }

    func requestLocation() {
        isRequestLocationCalled = true
    }
}
