//
//  IssueTileView.swift
//  Kouch
//
//  Created by Ranjith Menon on 07/04/2026.
//

import SwiftUI

struct IssueTileView: View {
    let issue: Issue

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center) {
                Image(systemName: issue.state == "open" ? "circle.circle" : "checkmark.circle.fill")
                    .foregroundColor(issue.state == "open" ? .green : .purple)
                    .font(.subheadline)

                Text(issue.repository?.fullName ?? "Unknown Repo")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)

                Spacer()

                Text("#\(issue.number)")
                    .font(.caption)
                    .monospacedDigit()
                    .foregroundStyle(.tertiary)
            }
            Text(issue.title ?? "No Title")
                .font(.headline)
                .fontWeight(.semibold)
                .lineLimit(2)
                .multilineTextAlignment(.leading)

            if let labels = issue.labels, !labels.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 4) {
                        ForEach(labels) { label in
                            CapsuleLabel(label: label)
                        }
                    }
                }
            }

            HStack(spacing: 12) {
                AsyncImage(url: URL(string: issue.user?.avatarUrl ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray
                }
                .frame(width: 20, height: 20)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color(.systemBackground), lineWidth: 1.5))

                Text(issue.user?.login ?? "")

                // Comments
                if let commentCount = issue.comments, commentCount > 0 {
                    Label("\(commentCount)", systemImage: "bubble.right")
                }

                Spacer()

                // Assignees Stack
                if let assignees = issue.assignees, !assignees.isEmpty {
                    AssigneeStack(assignees: assignees)
                }

                if let createdAt = issue.createdAt {
                    Text(createdAt.relativeFormatted)
                }
            }
            .font(.caption2)
            .foregroundStyle(.secondary)
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

#Preview {
    IssueTileView(
        issue: Issue(
            id: 1,
            user: nil,
            title: "Example Issue Title",
            number: 42,
            labels: nil,
            state: "open",
            locked: false,
            comments: 5,
            createdAt: Date(),
            updatedAt: nil,
            closedAt: nil,
            assignees: nil,
            repository: nil,
            body: nil
        )
    )
    .padding()
}
