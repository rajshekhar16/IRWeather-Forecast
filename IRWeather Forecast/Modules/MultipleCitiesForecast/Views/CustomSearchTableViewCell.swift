//
//  CustomSearchTableViewCell.swift
//  IRWeather Forecast
//
//  Created by Rajshekhar on 17/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import UIKit

class CustomSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    var cityModel: CityModel? {
        didSet {
            cityLbl.text = cityModel?.name
            countryLbl.text = cityModel?.country
        }
    }

    static var identifier: String {
        return String(describing: self)
    }
    
}
