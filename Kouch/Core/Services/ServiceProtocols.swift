//
//  ServiceProtocols.swift
//  Kouch
//
//  Created by Ranjith Menon on 28/04/2026.
//

import Foundation

/// Protocol for issues-related API operations.
nonisolated protocol IssuesServiceProtocol: Sendable {
    func fetchIssues() async throws -> [Issue]
    func fetchIssueComments(repoName: String, issueNumber: Int) async throws -> [Comment]
}

/// Protocol for repository-related API operations.
nonisolated protocol ReposServiceProtocol: Sendable {
    func fetchRepos() async throws -> [Repository]
}

/// Protocol for user-related API operations.
nonisolated protocol UserServiceProtocol: Sendable {
    func fetchUser() async throws -> User
}
