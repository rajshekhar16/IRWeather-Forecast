//
//  CurrentCityForecastTableViewCell.swift
//  IRWeather Forecast
//
//  Created by Rajshekhar on 16/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import UIKit

class CurrentCityForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var weatherDesc: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        timeLbl.text = nil
        tempLbl.text = nil
        humidityLbl.text = nil
        weatherDesc.text = nil
        weatherImg.image = nil
    }

    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    static var identifier: String {
        return String(describing: self)
    }

    var presentableData: ForecastPresentableData? {
        didSet {
            timeLbl.text = presentableData?.time
            tempLbl.text = presentableData?.temp
            humidityLbl.text = presentableData?.humidity
            weatherDesc.text = presentableData?.weather.localizedCapitalized
            weatherImg.loadThumbImageUsingCacheWithUrlString(presentableData?.weatherImgUrl ?? "")
        }
    }
    
}
