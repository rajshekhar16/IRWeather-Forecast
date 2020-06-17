//
//  IRWeather_ForecastTests.swift
//  IRWeather ForecastTests
//
//  Created by Rajshekhar on 15/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import XCTest
@testable import IRWeather_Forecast

class IRWeather_ForecastTests: XCTestCase {

    var sut: LandingPageViewController!

    override func setUp() {
        super.setUp()
        sut = makeSut()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_Navigate_toCurrrentCityForecastController() {
        sut.curretnCityAction(self)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if let navigationContoller = UIApplication.shared.windows.first,
                let topViewController = navigationContoller.rootViewController?.children.first {
                XCTAssertTrue(topViewController.isKind(of:  CurrentCityForecastViewController.self))
            }
        }
    }

    func test_Navigate_toMultipleCitiesSearchController() {
          sut.multipleCityAction(self)
          DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
              if let navigationContoller = UIApplication.shared.windows.first,
                  let topViewController = navigationContoller.rootViewController?.children.first {
                  XCTAssertTrue(topViewController.isKind(of:  SearchCityViewController.self))
              }
          }
      }

   // MARK: Helpers
   func makeSut() -> LandingPageViewController? {
       let storyboard = UIStoryboard(name: "Main",
                                     bundle: Bundle.main)
       let sut = storyboard.instantiateViewController(withIdentifier: "ViewController") as? LandingPageViewController
       let navigationController = UINavigationController()
       navigationController.viewControllers = [sut!]
       let _ = sut!.view
       return sut
   }

}
