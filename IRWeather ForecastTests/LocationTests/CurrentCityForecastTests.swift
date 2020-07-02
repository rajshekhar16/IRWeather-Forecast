//
//  CurrentCityForecastTests.swift
//  IRWeather ForecastTests
//
//  Created by Rajshekhar on 17/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import XCTest
@testable import IRWeather_Forecast


class CurrentCityForecastTests: XCTestCase {

    var sut: CurrentCityForecastViewController!
    var locationProvider: UserLocationProviderMock!

    override func setUp() {
        super.setUp()
        sut = makeSut()
    }

    override func tearDown() {
        sut = nil
        locationProvider = nil
        super.tearDown()
    }

    func testRequestUserLocation_NotAuthorized_ShouldFail() {
        // Given
        locationProvider.locationBlockLocationValue = UserLocationMock()
        locationProvider.locationBlockErrorValue    = UserLocationError.canNotBeLocated

        // When
        sut.requestUserLocation()

        // Then
        XCTAssertNil(sut.userLocation)
    }

    func testRequestUserLocation_Authorized_ShouldReturnUserLocation() {
        // Given
        locationProvider.locationBlockLocationValue = UserLocationMock()

        // When
        sut.requestUserLocation()

        // Then
        XCTAssertNotNil(sut.userLocation)
    }

    // MARK: Helpers
    func makeSut() -> CurrentCityForecastViewController? {
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: Bundle.main)
        let sut = storyboard.instantiateViewController(withIdentifier: "CurrentCityForecastViewController") as? CurrentCityForecastViewController
        locationProvider = UserLocationProviderMock()
        sut?.locationProvider = locationProvider
        let navigationController = UINavigationController()
        navigationController.viewControllers = [sut!]
        _ = sut!.view
        return sut
    }
}
