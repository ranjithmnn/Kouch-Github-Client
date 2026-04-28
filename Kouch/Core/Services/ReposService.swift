//
//  ReposService.swift
//  Kouch
//
//  Created by Ranjith Menon on 07/04/2026.
//

import Foundation

/// Handles all repository-related API calls.
nonisolated struct ReposService: ReposServiceProtocol {
    private let networking: APINetworking

    init(networking: APINetworking = .shared) {
        self.networking = networking
    }

    func fetchRepos() async throws -> [Repository] {
        try await networking.fetch(.userRepos)
    }
}
