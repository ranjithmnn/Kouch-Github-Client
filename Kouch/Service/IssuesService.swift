//
//  IssuesService.swift
//  Kouch
//
//  Created by Ranjith Menon on 06/04/2026.
//

import Foundation

class IssuesService {
    func fetchIssues(completion: @escaping (Result<[Issue], Error>) -> Void) {
        APINetworking().apiCall(endPoint: .issues) { result in
            switch result {
            case .success(let data):
                do {
                    let issues = try JSONDecoder().decode([Issue].self, from: data)
                    completion(.success(issues))
                } catch {
                    completion(.failure(error))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
