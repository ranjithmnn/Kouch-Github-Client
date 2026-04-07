//
//  ReposSetvice.swift
//  Kouch
//
//  Created by Ranjith Menon on 07/04/2026.
//

import Foundation

class ReposService {
    func fetchRepos(completion: @escaping (Result<[Repository], Error>) -> Void) {
        APINetworking().apiCall(endPoint: .userRepos) { result in
            switch result {
            case .success(let data):
                do {
                    let repos = try JSONDecoder().decode([Repository].self, from: data)
                    completion(.success(repos))
                } catch {
                    completion(.failure(error))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
