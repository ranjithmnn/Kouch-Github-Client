//
//  Repository.swift
//  Kouch
//
//  Created by Ranjith Menon on 06/04/2026.
//

import SwiftUI

struct Repository: Codable {
    let name: String?
    let full_name: String?
    let owner: User?
    let description: String?
    let language: String?
    let stargazers_count: Int?
    let forks_count: Int?
    let visibility: String?
    let updated_at: String?
}
