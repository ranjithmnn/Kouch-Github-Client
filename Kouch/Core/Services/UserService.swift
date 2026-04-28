//
//  UserService.swift
//  Kouch
//
//  Created by Ranjith Menon on 06/04/2026.
//

import Foundation

/// Handles all user-related API calls.
nonisolated struct UserService: UserServiceProtocol {
    private let networking: APINetworking

    init(networking: APINetworking = .shared) {
        self.networking = networking
    }

    func fetchUser() async throws -> User {
        try await networking.fetch(.user)
    }
}
