//
//  NetworkService.swift
//  IRWeather Forecast
//
//  Created by Rajshekhar on 16/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import Foundation

protocol ForecastServiceProtocol {
    func fetchForecastDataForFiveDays(completionHandler: @escaping (Forecast5Response?, String?) -> Void)
}

struct ForecastService: ForecastServiceProtocol {
    let networkEngine: NetworkEngineProtocol

    func fetchForecastDataForFiveDays(completionHandler: @escaping (Forecast5Response?, String?) -> Void) {
        networkEngine.request { (result: Result<Forecast5Response, Error>) in
            switch result {
            case .success(let response):
                completionHandler(response, nil)
            case .failure(let error):
                completionHandler(nil, error.localizedDescription)
            }
        }
    }
}
