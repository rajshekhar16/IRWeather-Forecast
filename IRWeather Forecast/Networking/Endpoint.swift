//
//  Endpoint.swift
//  IRWeather Forecast
//
//  Created by Rajshekhar on 16/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import Foundation

protocol Endpoint {
    /// HTTP or HTTPS
    var scheme: String { get }

    // Example: "api.xyz.com"
    var baseURL: String { get }

    // "/service/rest/"
    var path: String { get }

    // [URLQueryItem(name: "api_key", value: API_KEY]
    var parameters: [URLQueryItem] { get }

    // "GET, POST, DELETE, PUT"
    var method: HttpMethod { get }
}


enum HttpMethod: String {
    case GET = "GET"
    case DELETE = "DELETE"
    case POST = "POST"
    case PUT = "PUT"
    case PATCH = "PATCH"
}
