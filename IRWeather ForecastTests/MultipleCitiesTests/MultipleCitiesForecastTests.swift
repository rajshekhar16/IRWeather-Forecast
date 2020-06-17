//
//  MultipleCitiesForecastTests.swift
//  IRWeather ForecastTests
//
//  Created by Rajshekhar on 18/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import XCTest

@testable import IRWeather_Forecast
class MultipleCitiesForecastTests: XCTestCase {

    var sut: CitiesForecastViewController!
    var forecastServiceMock: CitiesForecastServiceMock!

    override func setUp() {
        super.setUp()
        sut = makeSut()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_presentableData_isNotEmpty_afterCallingFetchData() {
        sut.citiesForecastViewModel.fetchData()
        XCTAssertNotEqual(sut.citiesForecastViewModel.presentableData.count, 0)
    }

    func test_viewDidLoad_renderPresentableData() {
        sut.citiesForecastViewModel.fetchData()
        XCTAssertEqual(sut.citiesForecastViewModel.presentableData.first?.cityName, "Seattle")
        XCTAssertEqual(sut.citiesForecastViewModel.presentableData.first?.minTemp, "14")
        XCTAssertEqual(sut.citiesForecastViewModel.presentableData.first?.maxTemp, "17")
        XCTAssertEqual(sut.citiesForecastViewModel.presentableData.first?.windSpeed, "2.1 mph")
        XCTAssertEqual(sut.citiesForecastViewModel.presentableData.first?.weather, "broken clouds")
    }

    func test_tableView_isNotHidden() {
         sut.citiesForecastViewModel.fetchData()
         sut.onFetchCompleted()
         XCTAssertEqual(sut?.citiesForecastTableView.isHidden, false)
     }


    func test_tableViewCell_rendersForecastOptionInCell() {
        sut.citiesForecastViewModel.fetchData()
        sut.setupTableView()
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut?.citiesForecastTableView.dataSource?.tableView(sut!.citiesForecastTableView,
                                                               cellForRowAt: indexPath) as? CityWeatherForecastTableViewCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.cityLbl.text, "Seattle")
        XCTAssertEqual(cell?.minTempLbl.text, "Min Temp: 14°")
        XCTAssertEqual(cell?.maxTempLbl.text, "Max Temp: 17°")
        XCTAssertEqual(cell?.windSpeedLbl.text, "2.1 mph")
        XCTAssertEqual(cell?.weatherDesc.text, "broken clouds".localizedCapitalized)
    }
//
    func test_tableViewCell_allOutletsAreResetInPrepareForeReuse() {
        sut.citiesForecastViewModel.fetchData()
        sut.setupTableView()
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut?.citiesForecastTableView.dataSource?.tableView(sut!.citiesForecastTableView,
                                                               cellForRowAt: indexPath) as? CityWeatherForecastTableViewCell
        cell?.prepareForReuse()
        XCTAssertNotNil(cell)
        XCTAssertNil(cell?.cityLbl.text)
        XCTAssertNil(cell?.minTempLbl.text)
        XCTAssertNil(cell?.maxTempLbl.text)
        XCTAssertNil(cell?.windSpeedLbl.text)
        XCTAssertNil(cell?.weatherDesc.text)
    }

    // MARK: Helpers
       func makeSut() -> CitiesForecastViewController? {
           let storyboard = UIStoryboard(name: "Main",
                                         bundle: Bundle.main)
           let sut = storyboard.instantiateViewController(withIdentifier: "CitiesForecastViewController") as? CitiesForecastViewController
           forecastServiceMock = CitiesForecastServiceMock()
           sut?.citiesForecastViewModel = CitiesForecastViewModel(cityNetworkServiceService: forecastServiceMock, delegate: nil)
           sut?.citiesForecastService = forecastServiceMock
           let navigationController = UINavigationController()
           navigationController.viewControllers = [sut!]
           let _ = sut!.view
           return sut
       }
}

