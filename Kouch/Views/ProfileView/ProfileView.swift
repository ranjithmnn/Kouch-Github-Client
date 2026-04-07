//
//  ProfileView.swift
//  Kouch
//
//  Created by Ranjith Menon on 06/04/2026.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(spacing: 16) {
                    AsyncImage(url: URL(string: user.avatar_url ?? "")) { image in
                        image.resizable().aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Circle().fill(.gray.opacity(0.2))
                    }
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.accentColor.opacity(0.2), lineWidth: 4))
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                    
                    Text(user.name ?? user.login ?? "Developer")
                        .font(.title.bold())
                }
                .padding(.top)

                HStack(spacing: 0) {
                    StatMetric(value: "\(user.public_repos ?? 0)", label: "Repos")
                    Divider().frame(height: 30)
                    StatMetric(value: "\(user.followers ?? 0)", label: "Followers")
                    Divider().frame(height: 30)
                    StatMetric(value: "\(user.following ?? 0)", label: "Following")
                }
                .padding(.vertical)
                .background(Color(.secondarySystemGroupedBackground))
                .cornerRadius(16)
                .padding(.horizontal)

                if let bio = user.bio {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("About")
                            .font(.headline)
                        Text(bio)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .lineSpacing(4)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(.secondarySystemGroupedBackground))
                    .cornerRadius(16)
                    .padding(.horizontal)
                }

                VStack(spacing: 0) {
                    InfoRow(icon: "building.2", label: "Company", value: user.company)
                    Divider().padding(.leading, 44)
                    InfoRow(icon: "mappin.and.ellipse", label: "Location", value: user.location)
                    Divider().padding(.leading, 44)
                    InfoRow(icon: "calendar", label: "Joined", value: formatJoinedDate(user.created_at))
                }
                .background(Color(.secondarySystemGroupedBackground))
                .cornerRadius(16)
                .padding(.horizontal)
                
                if user.total_private_repos ?? 0 > 0 {
                    HStack {
                        Label("Private Repositories", systemImage: "lock.shield")
                            .font(.footnote.bold())
                        Spacer()
                        Text("\(user.total_private_repos ?? 0)")
                            .font(.footnote.monospacedDigit())
                    }
                    .padding()
                    .background(Color.orange.opacity(0.1))
                    .foregroundStyle(.orange)
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
            }
            .padding(.bottom, 30)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("@\(user.login ?? "")")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Settings", systemImage: "gear") {
                    
                }
            }
        }
    }
    
    private func formatJoinedDate(_ dateStr: String?) -> String {
        guard let dateStr = dateStr,
              let date = try? Date(dateStr, strategy: .iso8601) else { return "Unknown" }
        return date.formatted(date: .abbreviated, time: .omitted)
    }
}


struct StatMetric: View {
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.headline)
                .fontWeight(.bold)
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

struct InfoRow: View {
    let icon: String
    let label: String
    let value: String?
    
    var body: some View {
        if let actualValue = value, !actualValue.isEmpty {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundStyle(.background)
                    .frame(width: 24)
                
                Text(label)
                    .font(.subheadline)
                
                Spacer()
                
                Text(actualValue)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding()
        }
    }
}
