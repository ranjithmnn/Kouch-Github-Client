//
//  Networking.swift
//  Kouch
//
//  Created by Ranjith Menon on 06/04/2026.
//

import Foundation

class APINetworking {
    func apiCall(endPoint: APIEndpoint, onComplete: @escaping (Result<Data, Error>) -> Void) {
        guard let request = endPoint.urlRequest else {
            onComplete(.failure(URLError(.badURL)))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                onComplete(.failure(error))
                return
            }

            guard let data = data else {
                onComplete(.failure(URLError(.zeroByteResource)))
                return
            }

            onComplete(.success(data))
        }
        task.resume()
    }
}
