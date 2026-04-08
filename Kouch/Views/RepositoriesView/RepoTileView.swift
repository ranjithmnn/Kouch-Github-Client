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
            // Header: Visibility & Full Name
            HStack(alignment: .center) {
                
                AsyncImage(url: URL(string: repo.owner?.avatar_url ?? "")) { image in
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
                
                Image(systemName: repo.visibility == "private" ? "lock.fill" : "")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            
            // Title & Description
            VStack(alignment: .leading, spacing: 4) {
                Text(repo.name ?? "No Name")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                if let description = repo.description {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }
            
            // Footer: Avatar, Stars, Forks, and Date
            HStack(spacing: 12) {
                
                if let lang = repo.language {
                    Text(lang)
                        .font(.system(size: 10, weight: .bold))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(Capsule().fill(Color.blue.opacity(0.1)))
                        .foregroundColor(.blue)
                }
                
                // Stats
                HStack(spacing: 8) {
                    Label("\(repo.stargazers_count ?? 0)", systemImage: "star")
                    Label("\(repo.forks_count ?? 0)", systemImage: "arrow.branch")
                }
                .font(.caption2)
                
                Spacer()
                
                Text(formatDate(repo.updated_at))
                    .font(.caption2)
            }
            .foregroundStyle(.secondary)
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
    
    private func formatDate(_ dateStr: String?) -> String {
        guard let dateStr = dateStr else { return "" }
        let strategy = Date.ISO8601FormatStyle()
        guard let date = try? Date(dateStr, strategy: strategy) else { return "" }
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}

#Preview {
    RepositoryList()
}
