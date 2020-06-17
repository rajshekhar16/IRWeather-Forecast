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
    var forecastViewModel: ForecastViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        requestUserLocation()
        self.navigationController?.navigationBar.isHidden = false


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
        self.title = cityName
        let networkEngine = NetworkEngine(with: WeatherEndPoints.getFiveDaysForecast(cityName: cityName))
        let forecastService = ForecastService(networkEngine: networkEngine)
        forecastViewModel = ForecastViewModel(forecastService: forecastService, delegate: self)
        setupTableView()
        forecastViewModel.fetchData()
    }

    func setupTableView() {
        forecastTableView.register(CurrentCityForecastTableViewCell.nib, forCellReuseIdentifier: CurrentCityForecastTableViewCell.identifier)
        forecastTableView.register(CurrentCityForecastHeaderCell.nib, forCellReuseIdentifier: CurrentCityForecastHeaderCell.identifier)
        forecastTableView.isHidden = true
        forecastTableView.dataSource = self
        forecastTableView.delegate = self
    }
}

extension CurrentCityForecastViewController: ForecastViewModelDelegate {

    func onFetchCompleted() {
        forecastTableView.isHidden = false
        forecastTableView.reloadData()
    }

    func onFetchFailed(with reason: String) {

    }
}

extension CurrentCityForecastViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return forecastViewModel.presentableData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastViewModel.presentableData[section].count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "CurrentCityForecastHeaderCell") as? CurrentCityForecastHeaderCell
        headerCell?.dayLbl.text = forecastViewModel.presentableData[section][0].day
        headerCell?.dateLbl.text = forecastViewModel.presentableData[section][0].shortDate
        return headerCell
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: CurrentCityForecastTableViewCell.identifier, for: indexPath) as? CurrentCityForecastTableViewCell else {
            fatalError("Unable to dequeue cell")
        }
        tableViewCell.presentableData = forecastViewModel.presentableData[indexPath.section][indexPath.row]
        return tableViewCell
    }

}
