//
//  ForecastViewModel.swift
//  IRWeather Forecast
//
//  Created by Rajshekhar on 16/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import Foundation

protocol ForecastViewModelDelegate: class {
  func onFetchCompleted()
  func onFetchFailed(with reason: String)
}

let urlStr = "https://openweathermap.org/img/w/"

final class ForecastViewModel {

    weak var delegate: ForecastViewModelDelegate?

    private var forecastService: ForecastServiceProtocol?

    init(forecastService: ForecastServiceProtocol, delegate: ForecastViewModelDelegate?) {
        self.delegate = delegate
        self.forecastService = forecastService
    }

    var presentableData: [[ForecastPresentableData]] = []

    func fetchData() {
        forecastService?.fetchForecastDataForFiveDays(completionHandler: { [weak self] (response, error) in
            guard let self = self else { return }
            let data = self.groupData(weatherData: response!.list)
            let keys = data.keys.sorted()
            keys.sorted().forEach { (key) in
                let values = data[key]!
                var presentableArr: [ForecastPresentableData] = []
                for value in values {
                    var date: DateUtilities? = DateUtilities(dateInDouble: value.dt)
                    var presentableData: ForecastPresentableData? = ForecastPresentableData(shortDate: date?.shortDate ?? "",
                                                                                            day:  date?.day ?? "",
                                                                                            time: date?.time,
                                                                                            temp: "\(Int(round(value.main.temp)))",
                        humidity: "\(value.main.humidity)",
                        weather: value.weather.first!.description,
                        weatherImgUrl: "\(urlStr)\(value.weather.first!.icon).png",
                        windSpeed: "\(value.wind.speed)")
                    presentableArr.append(presentableData!)
                    date = nil
                    presentableData = nil
                }
                self.presentableData.append(presentableArr)
            }
            DispatchQueue.main.async {
                self.delegate?.onFetchCompleted()
            }
        })
    }

    func groupData(weatherData: [ListData]) -> [String : [ListData]] {
        let data = Dictionary<String, [ListData]>(grouping: weatherData, by: {
            let isoDate = $0.dt
            let date = Date(timeIntervalSince1970: isoDate)
            let formatDate = DateFormatter()
            formatDate.dateFormat = "yyyy-MM-dd"
            return formatDate.string(from: date)
        })
        return data
    }
}
