//
//  RepoTileView.swift
//  Kouch
//
//  Created by Ranjith Menon on 08/04/2026.
//

import SwiftUI

struct RepoTileView: View {
    let repo: Repository

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header: Owner Avatar & Name
            HStack(alignment: .center) {
                AsyncImage(url: URL(string: repo.owner?.avatarUrl ?? "")) { image in
                    image.resizable().aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray
                }
                .frame(width: 20, height: 20)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color(.systemBackground), lineWidth: 1.5))

                Text(repo.owner?.login ?? "Unknown")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)

                Spacer()

                if repo.visibility == "private" {
                    Image(systemName: "lock.fill")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }

            // Title & Description
            VStack(alignment: .leading, spacing: 4) {
                Text(repo.name)
                    .font(.headline)
                    .fontWeight(.semibold)

                if let description = repo.description {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }

            // Footer: Language, Stats, Date
            HStack(spacing: 12) {
                if let lang = repo.language {
                    Text(lang)
                        .font(.system(size: 10, weight: .bold))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(Capsule().fill(Color.blue.opacity(0.1)))
                        .foregroundColor(.blue)
                }

                HStack(spacing: 8) {
                    Label("\(repo.stargazersCount ?? 0)", systemImage: "star")
                    Label("\(repo.forksCount ?? 0)", systemImage: "arrow.branch")
                }
                .font(.caption2)

                Spacer()

                if let updatedAt = repo.updatedAt {
                    Text(updatedAt.relativeFormatted)
                        .font(.caption2)
                }
            }
            .foregroundStyle(.secondary)
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

#Preview {
    RepoTileView(
        repo: Repository(
            id: 1,
            name: "kouch",
            fullName: "ranjithmenon/kouch",
            owner: nil,
            description: "A GitHub client for iOS",
            language: "Swift",
            stargazersCount: 12,
            forksCount: 3,
            visibility: "public",
            updatedAt: Date()
        )
    )
    .padding()
}
