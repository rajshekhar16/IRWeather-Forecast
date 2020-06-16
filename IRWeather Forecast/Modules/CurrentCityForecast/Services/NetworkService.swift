//
//  NetworkService.swift
//  IRWeather Forecast
//
//  Created by Rajshekhar on 16/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import Foundation

struct NetworkService {

    let networkEngine: NetworkEngine

    func fetchForecastDataForFiveDays() {
        networkEngine.request {(result: Result<Forecast5Response, Error>) in
            switch result {
            case .success(let response):
                print("Response: ", response)
            case .failure(let error):
                print(error)

            }
        }
    }

}
