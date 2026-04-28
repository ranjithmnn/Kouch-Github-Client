//
//  IssuesService.swift
//  Kouch
//
//  Created by Ranjith Menon on 06/04/2026.
//

import Foundation

/// Handles all issue-related API calls.
nonisolated struct IssuesService: IssuesServiceProtocol {
    private let networking: APINetworking

    init(networking: APINetworking = .shared) {
        self.networking = networking
    }

    func fetchIssues() async throws -> [Issue] {
        try await networking.fetch(.issues)
    }

    func fetchIssueComments(repoName: String, issueNumber: Int) async throws -> [Comment] {
        let endpoint = APIEndpoint.issueComments(repo: repoName, number: issueNumber)
        return try await networking.fetch(endpoint)
    }
}
