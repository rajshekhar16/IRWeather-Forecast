//
//  CitiesForecastNetworkService.swift
//  IRWeather Forecast
//
//  Created by Rajshekhar on 17/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import Foundation

import Foundation

protocol CitiesServiceProtocol {
    func fetchForecastForMultipleCities(completionHandler: @escaping (CitiesForecastResponse?, String?) -> Void)
}

struct CitiesForecastService: CitiesServiceProtocol {
    let networkEngine: NetworkEngineProtocol
    func fetchForecastForMultipleCities(completionHandler: @escaping (CitiesForecastResponse?, String?) -> Void) {
        networkEngine.request { (result: Result<CitiesForecastResponse, Error>) in
            switch result {
            case .success(let response):
                completionHandler(response, nil)
            case .failure(let error):
                completionHandler(nil, error.localizedDescription)
            }
        }
    }
}
