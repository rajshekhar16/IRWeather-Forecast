//
//  Forecast5Tests.swift
//  IRWeather ForecastTests
//
//  Created by Rajshekhar on 17/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import XCTest
@testable import IRWeather_Forecast
class Forecast5Tests: XCTestCase {

    var sut: CurrentCityForecastViewController!
    var locationProvider: UserLocationProviderMock!
    var forecastServiceMock: ForecastServiceMock!

    override func setUp() {
        super.setUp()
        sut = makeSut()
    }

    override func tearDown() {
        sut = nil
        locationProvider = nil
        super.tearDown()
    }

    func test_presentableData_isNotEmpty_afterCallingFetchData() {
        sut.forecastViewModel.fetchData()
        XCTAssertNotEqual(sut.forecastViewModel.presentableData.count, 0)
    }

    func test_viewDidLoad_renderPresentableData() {
        sut.forecastViewModel.fetchData()
        XCTAssertEqual(sut.forecastViewModel.presentableData[0][0].day, "Tuesday")
        XCTAssertEqual(sut.forecastViewModel.presentableData[0][0].weather, "overcast clouds")
        XCTAssertEqual(sut.forecastViewModel.presentableData[0][0].time, "8:30 PM")
        XCTAssertEqual(sut.forecastViewModel.presentableData[0][0].humidity, "90")
    }

    func test_tableView_isNotHidden() {
         sut.forecastViewModel.fetchData()
         sut.onFetchCompleted()
         XCTAssertEqual(sut?.forecastTableView.isHidden, false)
     }

    func test_tableView_numberOfSections_shouldbeFive() {
        sut.forecastViewModel.fetchData()
        sut.forecastViewModel.delegate?.onFetchCompleted()
        sut.setupTableView()
        XCTAssertEqual(sut?.forecastTableView.numberOfSections, 5)
    }

    func test_tableViewCell_rendersForecastOptionInCell() {
        sut.forecastViewModel.fetchData()
        sut.setupTableView()
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut?.forecastTableView.dataSource?.tableView(sut!.forecastTableView,
                                                               cellForRowAt: indexPath) as? CurrentCityForecastTableViewCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.timeLbl.text, "8:30 PM")
        XCTAssertEqual(cell?.tempLbl.text, "285")
        XCTAssertEqual(cell?.humidityLbl.text, "90")
        XCTAssertEqual(cell?.weatherDesc.text, "overcast clouds".localizedCapitalized)
    }

    func test_tableViewCell_allOutletsAreResetInPrepareForeReuse() {
        sut.forecastViewModel.fetchData()
        sut.setupTableView()
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut?.forecastTableView.dataSource?.tableView(sut!.forecastTableView,
                                                               cellForRowAt: indexPath) as? CurrentCityForecastTableViewCell
        cell?.prepareForReuse()
        XCTAssertNotNil(cell)
        XCTAssertNil(cell?.timeLbl.text)
        XCTAssertNil(cell?.tempLbl.text)
        XCTAssertNil(cell?.humidityLbl.text)
        XCTAssertNil(cell?.weatherDesc.text)
    }

    func test_tableViewHeader_ViewIsNotNil() {
        sut.forecastViewModel.fetchData()
        sut.setupTableView()
        let headerView = sut?.forecastTableView.delegate?.tableView?(sut!.forecastTableView, viewForHeaderInSection: 0)
        XCTAssertNotNil(headerView)
    }

    func test_tableViewHeader_ViewIsCurrentCityForecastHeaderCell() {
         sut.forecastViewModel.fetchData()
         sut.setupTableView()
         let headerView = sut?.forecastTableView.delegate?.tableView?(sut!.forecastTableView, viewForHeaderInSection: 0) as? CurrentCityForecastHeaderCell
         XCTAssertNotNil(headerView)
     }

    func test_tableViewHeaderCell_rendersForecastOptionInCell() {
         sut.forecastViewModel.fetchData()
         sut.setupTableView()
         let headerView = sut?.forecastTableView.delegate?.tableView?(sut!.forecastTableView, viewForHeaderInSection: 0) as? CurrentCityForecastHeaderCell
         XCTAssertNotNil(headerView)
        XCTAssertEqual(headerView?.dateLbl.text, "January 07")
        XCTAssertEqual(headerView?.dayLbl.text, "Tuesday")
     }

    func test_tableViewHeaderCell_allOutletsAreResetInPrepareForeReuse() {
        sut.forecastViewModel.fetchData()
        sut.setupTableView()
        let headerView = sut?.forecastTableView.delegate?.tableView?(sut!.forecastTableView, viewForHeaderInSection: 0) as? CurrentCityForecastHeaderCell
        XCTAssertNotNil(headerView)
        headerView?.prepareForReuse()
        XCTAssertNil(headerView?.dayLbl.text)
        XCTAssertNil(headerView?.dateLbl.text)
    }

    func test_tableView_numberOfRows() {
        sut.forecastViewModel.fetchData()
        sut.setupTableView()
        XCTAssertEqual(sut?.forecastTableView.numberOfRows(inSection: 0), 1)
    }

    func test_tableViewHeaderCell_dateVariableProperty() {
        sut.forecastViewModel.fetchData()
        sut.setupTableView()
        let headerView = sut?.forecastTableView.delegate?.tableView?(sut!.forecastTableView, viewForHeaderInSection: 0) as? CurrentCityForecastHeaderCell
        XCTAssertNotNil(headerView)
        headerView?.date = 1592386985
        XCTAssertNotNil(headerView?.date)
        XCTAssertEqual(headerView?.dateLbl.text, "June 17")
        XCTAssertEqual(headerView?.dayLbl.text, "Wednesday")
    }

    // MARK: Helpers
       func makeSut() -> CurrentCityForecastViewController? {
           let storyboard = UIStoryboard(name: "Main",
                                         bundle: Bundle.main)
           let sut = storyboard.instantiateViewController(withIdentifier: "CurrentCityForecastViewController") as? CurrentCityForecastViewController
           locationProvider = UserLocationProviderMock()
           sut?.locationProvider = locationProvider
           forecastServiceMock = ForecastServiceMock()
           sut?.forecastViewModel = ForecastViewModel(forecastService: forecastServiceMock, delegate: nil)
           let navigationController = UINavigationController()
           navigationController.viewControllers = [sut!]
           let _ = sut!.view
           return sut
       }
}



