//
//  Comment.swift
//  Kouch
//
//  Created by Ranjith Menon on 14/04/2026.
//

import Foundation

nonisolated struct Comment: Codable, Identifiable, Hashable, Sendable {
    let id: Int
    let user: User?
    let createdAt: Date?
    let updatedAt: Date?
    let body: String?

    enum CodingKeys: String, CodingKey {
        case id, user, body
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
