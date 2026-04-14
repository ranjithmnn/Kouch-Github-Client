//
//  Coment.swift
//  Kouch
//
//  Created by Ranjith Menon on 14/04/2026.
//

import SwiftUI

struct Comment: Codable {
    var id: Int
    var user: User?
    var created_at: String?
    var updated_at: String?
    var body: String?
}
