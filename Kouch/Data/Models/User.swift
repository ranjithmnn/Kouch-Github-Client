//
//  User.swift
//  Kouch
//
//  Created by Ranjith Menon on 06/04/2026.
//

import SwiftUI

struct User: Codable {
    var login: String?
    var id: Int?
    var node_id: String?
    var avatar_url: String?
    var followers_url: String?
    var following_url: String?
    var repos_url: String?
    var name: String?
    var company: String?
    var location: String?
    var bio: String?
    var public_repos: Int?
    var public_gists: Int?
    var followers: Int?
    var following: Int?
    var created_at: String?
    var total_private_repos: Int?
    var owned_private_repos: Int?
}
