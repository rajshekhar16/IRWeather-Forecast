//
//  Utilities.swift
//  IRWeather Forecast
//
//  Created by Rajshekhar on 16/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import Foundation

class DataConversion {
    
    private let fileName: String
    private let fileExtension: String
    private let bundle = Bundle.main
    private let path: String
    
    init?(fileName: String, fileExtension: String) {
        if let path = bundle.path(forResource: fileName, ofType: "json") {
            self.path = path
            self.fileName = fileName
            self.fileExtension = fileExtension
        } else {
            return nil
        }
    }
    
    func getDataFromFile() -> Data? {
        return try? Data(contentsOf: URL(fileURLWithPath: self.path))
    }
}

extension DataConversion {
    func decodeData<T: Decodable>(data: Data?) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data!)
    }
}
