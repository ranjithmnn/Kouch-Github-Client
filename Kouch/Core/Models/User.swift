//
//  User.swift
//  Kouch
//
//  Created by Ranjith Menon on 06/04/2026.
//

import Foundation

nonisolated struct User: Codable, Identifiable, Hashable, Sendable {
    let id: Int
    let login: String
    let nodeId: String?
    let avatarUrl: String?
    let followersUrl: String?
    let followingUrl: String?
    let reposUrl: String?
    let name: String?
    let company: String?
    let location: String?
    let bio: String?
    let publicRepos: Int?
    let publicGists: Int?
    let followers: Int?
    let following: Int?
    let createdAt: Date?
    let totalPrivateRepos: Int?
    let ownedPrivateRepos: Int?

    enum CodingKeys: String, CodingKey {
        case id, login, name, company, location, bio, followers, following
        case nodeId = "node_id"
        case avatarUrl = "avatar_url"
        case followersUrl = "followers_url"
        case followingUrl = "following_url"
        case reposUrl = "repos_url"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case createdAt = "created_at"
        case totalPrivateRepos = "total_private_repos"
        case ownedPrivateRepos = "owned_private_repos"
    }
}
