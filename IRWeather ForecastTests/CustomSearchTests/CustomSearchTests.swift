//
//  CustomSearchTests.swift
//  IRWeather ForecastTests
//
//  Created by Rajshekhar on 17/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import XCTest
@testable import IRWeather_Forecast
class CustomSearchTests: XCTestCase {

    var sut: SearchCityViewController!

    override func setUp() {
        super.setUp()
        sut = makeSut()
    }

    func test_searchTableView_notHidden() {
        sut.searchTextField.textFieldDidChange()
        sut.searchTextField.layoutSubviews()
        XCTAssertEqual(sut.searchTextField.searchTableView?.isHidden, false)
    }

    func test_searchTableView_resultData_notEmpty_onsuccessfullSearch() {
        sut.searchTextField.textFieldDidChange()
        sut.searchTextField.text = "Mumbai"
        sut.searchTextField.layoutSubviews()
        cityModelArray.append(CityModel(id: 1, name: "Mumbai", country: "In"))
        sut.searchTextField.textFieldDidChange()
        XCTAssertEqual(sut.searchTextField.results.isEmpty, false)
    }

    func test_searchTableView_resultData_Empty_onUnsuccessfullSearch() {
         sut.searchTextField.textFieldDidChange()
         sut.searchTextField.text = "New Delhi"
         sut.searchTextField.layoutSubviews()
         sut.searchTextField.textFieldDidChange()
         XCTAssertEqual(sut.searchTextField.results.isEmpty, true)
     }

    func test_searchTableView_resultData_PopulatingCorrectly_onSearch() {
        sut.searchTextField.textFieldDidChange()
        sut.searchTextField.text = "New Delhi"
        sut.searchTextField.layoutSubviews()
        sut.searchTextField.textFieldDidChange()
        XCTAssertEqual(sut.searchTextField.results.isEmpty, true)
        sut.searchTextField.text = "Mumbai"
        sut.searchTextField.layoutSubviews()
        sut.searchTextField.textFieldDidChange()
        XCTAssertEqual(sut.searchTextField.results.isEmpty, false)
    }

    func test_tableViewCell_rendersCitiesOptionInCell() {
        sut.searchTextField.layoutSubviews()
        sut.searchTextField.text = "Mumbai"
        sut.searchTextField.textFieldDidChange()
        XCTAssertEqual(sut.searchTextField.results.isEmpty, false)
        sut.searchTextField.layoutSubviews()
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut?.searchTextField.searchTableView!.dataSource?.tableView(sut!.searchTextField.searchTableView!,
                                                                               cellForRowAt: indexPath) as? CustomSearchTableViewCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.cityLbl.text, "Mumbai")
        XCTAssertEqual(cell?.countryLbl.text, "In")

    }

    func test_tableView_onSelectRow_tableViewIsHidden() {
        sut.searchTextField.layoutSubviews()
        sut.searchTextField.text = "Mumbai"
        sut.searchTextField.textFieldDidChange()
        sut.searchTextField.layoutSubviews()
        let indexPath = IndexPath(row: 0, section: 0)
        sut?.searchTextField.searchTableView!.delegate?.tableView?(sut!.searchTextField.searchTableView!, didSelectRowAt: indexPath)
            XCTAssertEqual(sut.searchTextField.searchTableView?.isHidden, true)

    }

    func test_tableView_onSelectRow_textFieldIsEmpty() {
         sut.searchTextField.layoutSubviews()
         sut.searchTextField.text = "Mumbai"
         sut.searchTextField.textFieldDidChange()
         sut.searchTextField.layoutSubviews()
         let indexPath = IndexPath(row: 0, section: 0)
         sut?.searchTextField.searchTableView!.delegate?.tableView?(sut!.searchTextField.searchTableView!, didSelectRowAt: indexPath)
             XCTAssertEqual(sut.searchTextField.text?.isEmpty, true)

     }

    func test_selectedCitiesTableView_rendersCitiesOptionInCell() {
       sut.selectedCitiesArr.append(CityModel(id: 1, name: "Mumbai", country: "IN"))
       let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut?.selectedCitiesTableView.dataSource?.tableView(sut!.selectedCitiesTableView,
                                                                               cellForRowAt: indexPath) as? CustomSearchTableViewCell
                     XCTAssertEqual(cell?.cityLbl.text, "Mumbai")


    }

    func test_getForecastButton_isEnabled() {
        sut.selectedCitiesArr.append(CityModel(id: 1, name: "Mumbai", country: "IN"))
        sut.selectedCitiesArr.append(CityModel(id: 1, name: "New Delhi", country: "IN"))
        sut.selectedCitiesArr.append(CityModel(id: 1, name: "Bengaluru", country: "IN"))
        XCTAssertEqual(sut.forecastButton.isEnabled, true)
    }

    func test_getForecastButton_isDisabled() {
           sut.selectedCitiesArr.append(CityModel(id: 1, name: "Mumbai", country: "IN"))
           sut.selectedCitiesArr.append(CityModel(id: 1, name: "New Delhi", country: "IN"))
           XCTAssertEqual(sut.forecastButton.isEnabled, false)
       }

    func test_searchTextFieldShouldDisabled_selectedCountgreaterthan7() {
        sut.selectedCitiesArr.append(CityModel(id: 1, name: "Mumbai", country: "IN"))
        sut.selectedCitiesArr.append(CityModel(id: 1, name: "New Delhi", country: "IN"))
        sut.selectedCitiesArr.append(CityModel(id: 1, name: "Bengaluru", country: "IN"))
        sut.selectedCitiesArr.append(CityModel(id: 1, name: "Mumbai", country: "IN"))
        sut.selectedCitiesArr.append(CityModel(id: 1, name: "New Delhi", country: "IN"))
        sut.selectedCitiesArr.append(CityModel(id: 1, name: "Bengaluru", country: "IN"))
        sut.selectedCitiesArr.append(CityModel(id: 1, name: "New Delhi", country: "IN"))
        sut.selectedCitiesArr.append(CityModel(id: 1, name: "Bengaluru", country: "IN"))
        XCTAssertEqual(sut.searchTextField.isEnabled, false)
    }

    // MARK: Helpers
    func makeSut() -> SearchCityViewController? {
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: Bundle.main)
        let sut = storyboard.instantiateViewController(withIdentifier: "SearchCityViewController") as? SearchCityViewController
        let navigationController = UINavigationController()
        navigationController.viewControllers = [sut!]
        let _ = sut!.view
        return sut
    }

}
