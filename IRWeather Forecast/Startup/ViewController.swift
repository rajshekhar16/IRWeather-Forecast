//
//  ViewController.swift
//  IRWeather Forecast
//
//  Created by Rajshekhar on 15/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import UIKit

var cityModelArray: [CityModel] = []

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func curretnCityAction(_ sender: Any) {
        let currentCityViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CurrentCityForecastViewController") as! CurrentCityForecastViewController
        self.navigationController?.pushViewController(currentCityViewController, animated: true)

    }
    @IBAction func multipleCityAction(_ sender: Any) {
        let currentCityViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchCityViewController") as! SearchCityViewController
        self.navigationController?.pushViewController(currentCityViewController, animated: true)
    }

}

