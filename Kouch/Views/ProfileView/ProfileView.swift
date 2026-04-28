//
//  ProfileView.swift
//  Kouch
//
//  Created by Ranjith Menon on 06/04/2026.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var profileVm = ProfileViewModel()
    let user: User

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(spacing: 16) {
                    AsyncImage(url: URL(string: user.avatarUrl ?? "")) { image in
                        image.resizable().aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Circle().fill(.gray.opacity(0.2))
                    }
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.accentColor.opacity(0.2), lineWidth: 4))
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)

                    Text(user.name ?? user.login)
                        .font(.title.bold())
                }
                .padding(.top)

                HStack(spacing: 0) {
                    StatMetric(value: "\((user.publicRepos ?? 0) + (user.totalPrivateRepos ?? 0))", label: "Repos")
                    Divider().frame(height: 30)
                    StatMetric(value: "\(user.followers ?? 0)", label: "Followers")
                    Divider().frame(height: 30)
                    StatMetric(value: "\(user.following ?? 0)", label: "Following")
                }
                .padding(.vertical)
                .background(Color(.secondarySystemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))
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
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)
                }

                VStack(spacing: 0) {
                    InfoRow(icon: "building.2", label: "Company", value: user.company)
                    Divider().padding(.leading, 44)
                    InfoRow(icon: "mappin.and.ellipse", label: "Location", value: user.location)
                    Divider().padding(.leading, 44)
                    InfoRow(icon: "calendar", label: "Joined", value: user.createdAt?.shortFormatted)
                }
                .background(Color(.secondarySystemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal)
            }
            .padding(.bottom, 30)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("@\(user.login)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: Text("Settings")) {
                    Image(systemName: "gear")
                }
            }
        }
        .refreshable {
            await profileVm.fetchUser()
        }
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
                    .foregroundStyle(.foreground)
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
