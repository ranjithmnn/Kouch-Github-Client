//
//  UserService.swift
//  Kouch
//
//  Created by Ranjith Menon on 06/04/2026.
//

import Foundation

class UserService {
    func fetchUser(completion: @escaping (Result<User, Error>) -> Void) {
        APINetworking().apiCall(endPoint: .user) { result in
            switch result {
            case .success(let data):
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    completion(.success(user))
                } catch {
                    completion(.failure(error))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
