//
//  ViewController.swift
//  IRWeather Forecast
//
//  Created by Rajshekhar on 15/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let conversion = DataConversion(fileName: "city.list", fileExtension: "json") {
           // let daata = conversion.getDataFromFile()
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func curretnCityAction(_ sender: Any) {
        let currentCityViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CurrentCityForecastViewController") as! CurrentCityForecastViewController
        self.navigationController?.pushViewController(currentCityViewController, animated: true)

    }

}

