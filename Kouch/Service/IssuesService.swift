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
    
    func fetchIssueDetails(repoName: String?, issueNumber: Int?, completion: @escaping (Result<[Comment], Error>) -> Void) {
        if (repoName == nil) {return}
        if (issueNumber == nil) {return}
        let endpoint = APIEndpoint.issueComments(repo: repoName!, number: issueNumber!)
        APINetworking().apiCall(endPoint: endpoint) { result in
            switch result {
            case .success(let data):
                do {
                    let comments = try JSONDecoder().decode([Comment].self, from: data)
                    completion(.success(comments))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchIssueComments(repoName: String?, issueNumber: Int?, completion: @escaping (Result<[Comment], Error>) -> Void) {
        if (repoName == nil) {return}
        if (issueNumber == nil) {return}
        let endpoint = APIEndpoint.issueComments(repo: repoName!, number: issueNumber!)
        APINetworking().apiCall(endPoint: endpoint) { result in
            switch result {
            case .success(let data):
                do {
                    // 2. Decode into a Comment model (not Issue)
                    let comments = try JSONDecoder().decode([Comment].self, from: data)
                    completion(.success(comments))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
