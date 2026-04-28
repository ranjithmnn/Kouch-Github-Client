//
//  IssueCommentsTile.swift
//  Kouch
//
//  Created by Ranjith Menon on 14/04/2026.
//

import SwiftUI

struct IssueCommentsTile: View {
    let comment: Comment

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header: Avatar + Username + Timestamp
            HStack(alignment: .center, spacing: 10) {
                AsyncImage(url: URL(string: comment.user?.avatarUrl ?? "")) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Circle().fill(Color.gray.opacity(0.2))
                }
                .frame(width: 32, height: 32)
                .clipShape(Circle())

                VStack(alignment: .leading, spacing: 2) {
                    Text(comment.user?.login ?? "Anonymous")
                        .font(.system(size: 14, weight: .semibold))

                    if let createdAt = comment.createdAt {
                        Text(createdAt.relativeFormatted)
                            .font(.system(size: 11))
                            .foregroundColor(.secondary)
                    }
                }

                Spacer()
            }

            // Body Text
            Text(comment.body ?? "")
                .font(.system(size: 15))
                .lineSpacing(4)
                .foregroundColor(.primary.opacity(0.8))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    IssueCommentsTile(comment: Comment(id: 1, user: nil, createdAt: Date(), updatedAt: nil, body: "This is a sample comment"))
}
