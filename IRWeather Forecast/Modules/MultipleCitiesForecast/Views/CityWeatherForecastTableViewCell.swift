//
//  CityWeatherForecastTableViewCell.swift
//  IRWeather Forecast
//
//  Created by Rajshekhar on 17/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import UIKit

class CityWeatherForecastTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var windSpeedLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var maxTempLbl: UILabel!
    @IBOutlet weak var minTempLbl: UILabel!
    @IBOutlet weak var weatherDesc: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!

    override func prepareForReuse() {
        cityLbl.text = nil
        minTempLbl.text = nil
        maxTempLbl.text = nil
        weatherDesc.text = nil
        weatherImg.image = nil
        windSpeedLbl.text = nil
    }

    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    static var identifier: String {
        return String(describing: self)
    }

    var presentableData: CitiesForecastPresentableData? {
        didSet {
            cityLbl.text = presentableData?.cityName
            minTempLbl.text = "Min Temp: \(presentableData?.minTemp ?? "")°"
            maxTempLbl.text = "Max Temp: \(presentableData?.maxTemp ?? "")°"
            weatherDesc.text = presentableData?.weather.localizedCapitalized
            weatherImg.loadThumbImageUsingCacheWithUrlString(presentableData?.weatherImgUrl ?? "")
            windSpeedLbl.text = presentableData?.windSpeed
        }
    }
    
}
