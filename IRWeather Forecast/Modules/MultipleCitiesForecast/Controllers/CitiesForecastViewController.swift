//
//  CitiesForecastViewController.swift
//  IRWeather Forecast
//
//  Created by Rajshekhar on 17/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import UIKit

class CitiesForecastViewController: UIViewController {

    @IBOutlet weak var citiesForecastTableView: UITableView!
    var citiesForecastViewModel: CitiesForecastViewModel!
    var cityModelArr: [CityModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather Forecast"
        fetchWeatherReport()
        // Do any additional setup after loading the view.
    }

    func fetchWeatherReport() {
        let citiesId = self.cityModelArr.map { (cityModel) -> String in
            String(cityModel.id)
        }
        let networkEngine = NetworkEngine(with: WeatherEndPoints.getForecastOfCities(cityIDs: citiesId))
        let citiesForecastService = CitiesForecastService(networkEngine: networkEngine)
        citiesForecastViewModel = CitiesForecastViewModel(cityNetworkServiceService: citiesForecastService, delegate: self)
        citiesForecastViewModel.fetchData()

    }

    func setupTableView() {
        citiesForecastTableView.register(CityWeatherForecastTableViewCell.nib, forCellReuseIdentifier: CityWeatherForecastTableViewCell.identifier)
        citiesForecastTableView.dataSource = self
        citiesForecastTableView.reloadData()
    }
}

extension CitiesForecastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        citiesForecastViewModel.presentableData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: CityWeatherForecastTableViewCell.identifier, for: indexPath) as? CityWeatherForecastTableViewCell else {
            fatalError("Unable to dequeue cell")
        }
        tableViewCell.presentableData = citiesForecastViewModel.presentableData[indexPath.row]
        return tableViewCell
    }
}

extension CitiesForecastViewController: CitiesForecastViewModelDelegate {
    func onFetchCompleted() {
        setupTableView()
    }
}
