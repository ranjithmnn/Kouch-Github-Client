//
//  Repository.swift
//  Kouch
//
//  Created by Ranjith Menon on 06/04/2026.
//

import SwiftUI

struct Repository: Codable {
    var name: String?
    var full_name: String?
    var owner: User?
    var language: String?
}
