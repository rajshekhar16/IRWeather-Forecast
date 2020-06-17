//
//  DateUtilities.swift
//  IRWeather Forecast
//
//  Created by Rajshekhar on 16/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import Foundation

class DateUtilities {
    let dateInDouble: Double

    private var date: Date

    private var dateComponents: DateComponents

    init?(dateInDouble: Double) {
        self.dateInDouble = dateInDouble
        date = Date(timeIntervalSince1970: self.dateInDouble)
        self.dateComponents = Calendar.current.dateComponents([.weekday], from: date)
    }

    var day: String? {
        if let weekDay = dateComponents.weekday {
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone.current
            return dateFormatter.weekdaySymbols[weekDay - 1]
        }
        return nil
    }

    var shortDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd"
        return dateFormatter.string(from: date)
    }

    var time: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: date)
    }
}
