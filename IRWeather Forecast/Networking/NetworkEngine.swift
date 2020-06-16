//
//  NetworkEngine.swift
//  IRWeather Forecast
//
//  Created by Rajshekhar on 16/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import Foundation

protocol NetworkEngineProtocol {
    func request<T: Codable>(completion: @escaping (Result<T, Error>) -> ())
}

class NetworkEngine: NetworkEngineProtocol {

    private let urlSession: URLSessionProtocol
    private let endpoint: Endpoint

    convenience init(with endpoint: Endpoint) {
        self.init(urlSession: URLSession.shared, endpoint: endpoint)
    }

    init(urlSession: URLSessionProtocol, endpoint: Endpoint) {
        self.urlSession = urlSession
        self.endpoint = endpoint
    }

    /// Executes the web call and will decode the JSON response into the codable object provided
    /// - Parameters:
    ///   - endpoint: the endpoint to make the HTTP request against
    ///   - completion: the JSON response converted to the provided codable object. If successful, or fialure otherwise
    func request<T>(completion: @escaping (Result<T, Error>) -> ()) where T : Decodable {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters

        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = endpoint.method.rawValue

        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                completion(.failure(error!))
                print(error?.localizedDescription ?? "Unknown Error occured")
                return
            }

            guard response != nil, let data = data else { return }

            DispatchQueue.main.async {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let responseObject = try decoder.decode(T.self, from: data)
                    completion(.success(responseObject))
                }
                catch {
                    let error = NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey : "response"])
                    completion(.failure(error))
                    print(error)
                }
            }
        }
        task.resume()

    }
}
