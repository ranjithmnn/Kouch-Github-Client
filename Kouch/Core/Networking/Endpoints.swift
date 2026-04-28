//
//  Endpoints.swift
//  Kouch
//
//  Created by Ranjith Menon on 06/04/2026.
//

import Foundation

nonisolated enum APIEndpoint {
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

    /// Query parameters appended to the URL.
    var queryItems: [URLQueryItem]? {
        switch self {
        case .issues, .userRepos, .issueComments:
            return [URLQueryItem(name: "per_page", value: "100")]
        default:
            return nil
        }
    }

    private var baseURL: String {
        return "https://api.github.com"
    }

    /// Builds a fully configured `URLRequest` for this endpoint.
    var urlRequest: URLRequest {
        guard var components = URLComponents(string: baseURL + path) else {
            preconditionFailure("Invalid URL for endpoint: \(baseURL + path)")
        }

        components.queryItems = queryItems

        guard let url = components.url else {
            preconditionFailure("Failed to construct URL from components: \(components)")
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.timeoutInterval = 15.0
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let token = Bundle.main.object(forInfoDictionaryKey: "GITHUB_API_KEY") as? String ?? ""
        if token.isEmpty {
            assertionFailure("GITHUB_API_KEY is missing from Info.plist. Add it via Token.xcconfig.")
        }
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        return request
    }
}
