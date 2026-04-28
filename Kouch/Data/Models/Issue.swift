//
//  Issue.swift
//  Kouch
//
//  Created by Ranjith Menon on 06/04/2026.
//

import Foundation

nonisolated struct Issue: Codable, Identifiable, Hashable, Sendable {
    let id: Int
    let user: User?
    let title: String?
    let number: Int
    let labels: [IssueLabel]?
    let state: String?
    let locked: Bool?
    let comments: Int?
    let createdAt: Date?
    let updatedAt: Date?
    let closedAt: Date?
    let assignees: [User]?
    let repository: Repository?
    let body: String?

    enum CodingKeys: String, CodingKey {
        case id, user, title, number, labels, state, locked, comments
        case assignees, repository, body
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case closedAt = "closed_at"
    }
}

nonisolated struct IssueLabel: Codable, Identifiable, Hashable, Sendable {
    let id: Int
    let nodeId: String?
    let url: String?
    let name: String?
    let color: String?
    let description: String?

    enum CodingKeys: String, CodingKey {
        case id, url, name, color, description
        case nodeId = "node_id"
    }
}
