//
//  UserLocation.swift
//  IRWeather Forecast
//
//  Created by Rajshekhar on 16/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import Foundation
import CoreLocation

typealias Coordinate = CLLocationCoordinate2D

protocol UserLocation {
    func fetchCity(completion: @escaping (_ city: String?, _ error: Error?) -> Void)
    var coordinate: Coordinate { get }
}

extension CLLocation: UserLocation {
    func fetchCity(completion: @escaping (_ city: String?, _ error: Error?) -> Void) {
          CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $1) }
      }
}

enum UserLocationError: Swift.Error {
    case canNotBeLocated
}
