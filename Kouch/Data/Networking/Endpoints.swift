//
//  Endpoints.swift
//  Kouch
//
//  Created by Ranjith Menon on 06/04/2026.
//

import Foundation

enum APIEndpoint {
    case user
    case issues
    case issueComments(repo: String, number: Int)
    case userRepos

    var path: String {
        switch self {
        case .user:
            return "/user"
        case .issues:
            return "/issues"
        case .issueComments(let repo, let number):
            return "/repos/\(repo)/issues/\(number)/comments"
        case .userRepos:
            return "/user/repos"
        }
    }

    var method: String {
        return "GET"
    }

    var baseURL: String {
        return "https://api.github.com"
    }

    var urlRequest: URLRequest? {
        guard let url = URL(string: baseURL + path) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.timeoutInterval = 10.0
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Note: Ensure your API key is correctly fetched from Info.plist
        let token = Bundle.main.object(forInfoDictionaryKey: "GITHUB_API_KEY") as? String ?? ""
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        return request
    }
}
