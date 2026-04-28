//
//  AssigneeStack.swift
//  Kouch
//
//  Created by Ranjith Menon on 14/04/2026.
//

import SwiftUI

/// Displays overlapping avatar circles for assignees, with a "+N" overflow indicator.
struct AssigneeStack: View {
    let assignees: [User]
    let limit = 3

    var body: some View {
        HStack(spacing: -8) {
            ForEach(assignees.prefix(limit)) { user in
                AsyncImage(url: URL(string: user.avatarUrl ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray
                }
                .frame(width: 20, height: 20)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color(.systemBackground), lineWidth: 1.5))
            }

            if assignees.count > limit {
                Text("+\(assignees.count - limit)")
                    .font(.system(size: 8, weight: .bold))
                    .frame(width: 20, height: 20)
                    .background(Color(.secondarySystemFill))
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color(.systemBackground), lineWidth: 1.5))
            }
        }
    }
}