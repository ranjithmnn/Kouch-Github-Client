//
//  Issue.swift
//  Kouch
//
//  Created by Ranjith Menon on 06/04/2026.
//

import SwiftUI

struct Issue: Codable {
    var user: User?
    var title: String?
    var number: Int?
    var labels: [IssueLabel]?
    var state: String?
    var locked: Bool?
    var comments: Int?
    var created_at: String?
    var updated_at: String?
    var closed_at: String?
    var assignees: [User]?
    var repository: Repository?
    var body: String?
    
}

struct IssueLabel: Codable {
    var id: Int?
    var node_id: String?
    var url: String?
    var name: String?
    var color: String?
    var description: String?
}
