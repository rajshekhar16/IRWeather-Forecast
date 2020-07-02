//
//  CurrentCityForecastHeaderCell.swift
//  IRWeather Forecast
//
//  Created by Rajshekhar on 16/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import UIKit

class CurrentCityForecastHeaderCell: UITableViewCell {

    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        dayLbl.text = nil
        dateLbl.text = nil
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    static var identifier: String {
        return String(describing: self)
    }

    var date: Double? {
        didSet {
            let dateUtilities = DateUtilities(dateInDouble: date!)
            dayLbl.text = dateUtilities?.day ?? ""
            dateLbl.text = dateUtilities?.shortDate
        }
    }
}
