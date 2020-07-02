//
//  ViewController.swift
//  IRWeather Forecast
//
//  Created by Rajshekhar on 15/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import UIKit

var cityModelArray: [CityModel] = []

class LandingPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fillCitiesData()
    }

    private func fillCitiesData() {
        if let conversion = DataConversion(fileName: "city.list.min", fileExtension: "json") {
            DispatchQueue.global().async {
                guard let data = conversion.getDataFromFile() else { return }
                do {
                    cityModelArray = try JSONDecoder().decode([CityModel].self, from: data)
                } catch {
                    print("Error in decoding")
                }
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func curretnCityAction(_ sender: Any) {
        guard let currentCityForecastViewController = UIStoryboard(name: "Main",
                                                           bundle: nil)
            .instantiateViewController(withIdentifier: "CurrentCityForecastViewController") as? CurrentCityForecastViewController else {
            fatalError("Unable to instantiate CurrentCityForecastViewController")
        }
        self.navigationController?.pushViewController(currentCityForecastViewController, animated: true)
    }

    @IBAction func multipleCityAction(_ sender: Any) {
        guard let searchCityViewController = UIStoryboard(name: "Main",
                                                          bundle: nil)
            .instantiateViewController(withIdentifier: "SearchCityViewController") as? SearchCityViewController else {
                fatalError("Unable to instantiate SearchCityViewController")
        }
        self.navigationController?.pushViewController(searchCityViewController, animated: true)
    }
}
