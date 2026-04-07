//
//  Repository.swift
//  Kouch
//
//  Created by Ranjith Menon on 06/04/2026.
//

import SwiftUI

struct Repository: Codable, Identifiable {
    var id: Int
    var name: String?
    var full_name: String?
    var owner: User?
    var language: String?
    var description: String?
    var updated_at: String?
    var stargazers_count: Int?
}
