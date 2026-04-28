//
//  RepositoryList.swift
//  Kouch
//
//  Created by Ranjith Menon on 07/04/2026.
//

import SwiftUI

struct RepositoryList: View {
    @StateObject private var reposVm = RepositoriesViewModel()
    @State private var searchText = ""

    /// Filters repos by name or full name based on the search text.
    private var filteredRepos: [Repository] {
        guard !searchText.isEmpty else { return reposVm.repos }
        return reposVm.repos.filter { repo in
            repo.name.localizedCaseInsensitiveContains(searchText)
            || repo.fullName.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        ScrollView {
            if reposVm.isLoading {
                ProgressView("Fetching Repos…")
                    .frame(maxWidth: .infinity, minHeight: 200)
            } else if let errorMessage = reposVm.error {
                errorView(message: errorMessage)
            } else if filteredRepos.isEmpty {
                emptyView
            } else {
                LazyVStack(spacing: 8) {
                    ForEach(filteredRepos) { repo in
                        NavigationLink(destination: Text("Detail for \(repo.name)")) {
                            RepoTileView(repo: repo)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Repositories")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText, prompt: "Search your repositories")
        .task {
            await reposVm.fetchRepos()
        }
        .refreshable {
            await reposVm.fetchRepos()
        }
    }

    // MARK: - Error State

    private func errorView(message: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundStyle(.orange)
            Text("Something went wrong")
                .font(.headline)
            Text(message)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            Button("Retry") {
                Task { await reposVm.fetchRepos() }
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 200)
    }

    // MARK: - Empty State

    private var emptyView: some View {
        VStack(spacing: 12) {
            Image(systemName: "folder")
                .font(.largeTitle)
                .foregroundStyle(.secondary)
            Text(searchText.isEmpty ? "No repositories yet" : "No repos matching \"\(searchText)\"")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, minHeight: 200)
    }
}

#Preview {
    NavigationStack {
        RepositoryList()
    }
}
