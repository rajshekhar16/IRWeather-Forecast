//
//  SearchCityViewController.swift
//  IRWeather Forecast
//
//  Created by Rajshekhar on 17/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import UIKit

class SearchCityViewController: UIViewController {

    @IBOutlet weak var searchTextField: CustomSearchTextField!
    @IBOutlet weak var forecastButton: IRBorderButton!
    @IBOutlet weak var selectedCitiesTableView: UITableView!
    var selectedCitiesArr: [CityModel] = [] {
        didSet  {
            let arrCount = selectedCitiesArr.count
            if arrCount > 0 {
                selectedCitiesTableView.isHidden = false
                selectedCitiesTableView.reloadData()
            }
            if arrCount > 7 {
                searchTextField.isEnabled = false
            } else if arrCount < 3 {
                isButtonEnabled = false
            } else {
                isButtonEnabled = true
            }
        }
    }
    
    var isButtonEnabled: Bool = false {
        didSet {
            if isButtonEnabled {
                forecastButton.isEnabled = true
                forecastButton.backgroundColor = UIColor(red: 0, green: 171/255, blue: 255, alpha: 1.0)
            } else {
                forecastButton.isEnabled = false
                forecastButton.backgroundColor = UIColor.darkGray
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedCitiesTableView.register(CustomSearchTableViewCell.nib, forCellReuseIdentifier: CustomSearchTableViewCell.identifier)
        forecastButton.isEnabled = false
        searchTextField.customDelegate = self
        selectedCitiesTableView.dataSource = self
        forecastButton.backgroundColor = UIColor.darkGray
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Search Cities"
        // Do any additional setup after loading the view.
    }


    @IBAction func forecastAction(_ sender: Any) {

    }
}

extension SearchCityViewController: CustomSearchTextFieldDelegate {
    func onCellSelected(selectedCityModel: CityModel) {
        // Check whether selected cityModel is already added
        let index = selectedCitiesArr.firstIndex(where: { (cityModel) -> Bool in
            selectedCityModel.id == cityModel.id
        })
        if index == nil {
            selectedCitiesArr.append(selectedCityModel)
        }
    }
}

extension SearchCityViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectedCitiesArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomSearchTableViewCell", for: indexPath) as? CustomSearchTableViewCell else {
            fatalError("Error in dequeing cell")
        }
        let cityModel = selectedCitiesArr[indexPath.row]
        cell.cityModel = cityModel
        return cell
    }
}