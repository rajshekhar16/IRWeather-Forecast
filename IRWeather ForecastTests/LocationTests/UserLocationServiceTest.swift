//
//  UserLocationServiceTest.swift
//  IRWeather ForecastTests
//
//  Created by Rajshekhar on 16/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import XCTest
@testable import IRWeather_Forecast

class UserLocationServiceTests: XCTestCase {

    var sut: UserLocationService!
    var locationProvider: LocationProviderMock!

    override func setUp() {
        super.setUp()
        locationProvider = LocationProviderMock()
        sut = UserLocationService(with: locationProvider)
    }

    override func tearDown() {
        sut = nil
        locationProvider = nil
        super.tearDown()
    }

    func testRequestUserLocation_NotAuthorized_ShouldRequestAuthorization() {
        // Given
        locationProvider.isUserAuthorized = false

        // When
        sut.findUserLocation { _, _ in }

        // Then
        XCTAssertTrue(locationProvider.isRequestWhenInUseAuthorizationCalled)
    }

    func testRequestUserLocation_Authorized_ShouldNotRequestAuthorization() {
        // Given
        locationProvider.isUserAuthorized = true

        // When
        sut.findUserLocation { _, _ in }

        // Then
        XCTAssertFalse(locationProvider.isRequestWhenInUseAuthorizationCalled)
    }
}
