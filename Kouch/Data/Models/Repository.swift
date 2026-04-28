//
//  Repository.swift
//  Kouch
//
//  Created by Ranjith Menon on 06/04/2026.
//

import Foundation

nonisolated struct Repository: Codable, Identifiable, Hashable, Sendable {
    let id: Int
    let name: String
    let fullName: String
    let owner: User?
    let description: String?
    let language: String?
    let stargazersCount: Int?
    let forksCount: Int?
    let visibility: String?
    let updatedAt: Date?

    enum CodingKeys: String, CodingKey {
        case id, name, owner, description, language, visibility
        case fullName = "full_name"
        case stargazersCount = "stargazers_count"
        case forksCount = "forks_count"
        case updatedAt = "updated_at"
    }
}
