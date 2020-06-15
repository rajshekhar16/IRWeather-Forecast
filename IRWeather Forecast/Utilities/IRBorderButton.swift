//
//  IRBorderButton.swift
//  IRWeather Forecast
//
//  Created by Rajshekhar on 15/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import UIKit

class IRBorderButton: UIButton {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //setTheme(theme: CovidWarrierViewThemeConstants.covidTableViewTheme)
    }

    var shadowAdded: Bool = false

    @IBInspectable var cornerRadius: CGFloat = 0 {
           didSet {
               layer.cornerRadius = cornerRadius
               layer.masksToBounds = cornerRadius > 0
           }
       }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
        self.layer.masksToBounds = true
    }
}
