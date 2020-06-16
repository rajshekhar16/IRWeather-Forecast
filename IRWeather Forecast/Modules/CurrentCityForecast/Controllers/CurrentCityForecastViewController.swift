//
//  CurrentCityForecastViewController.swift
//  IRWeather Forecast
//
//  Created by Rajshekhar on 16/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import UIKit
import CoreLocation

class CurrentCityForecastViewController: UIViewController {

    @IBOutlet weak var forecastTableView: UITableView!
    var locationProvider: UserLocationProvider = UserLocationService(with: CLLocationManager())
    var userLocation: UserLocation? {
        didSet {
            userLocation?.fetchCity(completion: { [weak self] (cityName, error) in
                guard let citName = cityName else { print("City can not be located 😔"); return }
                self?.fetchForecastData(cityName: citName)
            })
        }
    }

    init(locationProvider: UserLocationProvider) {
        self.locationProvider = locationProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
       // fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        requestUserLocation()
        // Do any additional setup after loading the view.
    }

    func requestUserLocation() {
        locationProvider.findUserLocation { [weak self] location, error in
            if error == nil {
                self?.userLocation = location
            } else {
                print("User can not be located 😔")
            }
        }
    }

    func fetchForecastData(cityName: String) {
        let networkEngine = NetworkEngine(with: WeatherEndPoints.getFiveDaysForecast(cityName: cityName))
        let networkService = NetworkService(networkEngine: networkEngine)
        networkService.fetchForecastDataForFiveDays()
    }

}
