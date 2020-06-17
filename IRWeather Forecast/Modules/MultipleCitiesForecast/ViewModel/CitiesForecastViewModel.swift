//
//  CitiesForecastViewModel.swift
//  IRWeather Forecast
//
//  Created by Rajshekhar on 17/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import Foundation

protocol CitiesForecastViewModelDelegate: class {
  func onFetchCompleted()
}

final class CitiesForecastViewModel {

    weak var delegate: CitiesForecastViewModelDelegate?

    private var cityNetworkServiceService: CitiesServiceProtocol?

    init(cityNetworkServiceService: CitiesServiceProtocol, delegate: CitiesForecastViewModelDelegate?) {
        self.delegate = delegate
        self.cityNetworkServiceService = cityNetworkServiceService
    }

    var presentableData: [CitiesForecastPresentableData] = []

    func fetchData() {
        cityNetworkServiceService?.fetchForecastForMultipleCities(completionHandler: { [weak self] (cityForecastResponse, error) in
            guard let self = self else { return }
            if let cityForecastResponse = cityForecastResponse {
                for list in cityForecastResponse.list {
                    let cityPresentableData = CitiesForecastPresentableData(cityName: list.name, maxTemp: "\(Int(round(list.main.tempMax)))", minTemp: "\(Int(round(list.main.tempMin)))", humidity:"\(list.main.humidity)", weather: list.weather.first?.description ?? "", weatherImgUrl: "\(imgUrlStr)\(list.weather.first?.icon ?? "").png", windSpeed: "\(list.wind.speed) mph")
                    self.presentableData.append(cityPresentableData)
                }
                self.delegate?.onFetchCompleted()
            }


        })
    }

}

