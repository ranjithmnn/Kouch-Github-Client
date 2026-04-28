//
//  IssuesListView.swift
//  Kouch
//
//  Created by Ranjith Menon on 06/04/2026.
//

import SwiftUI

struct IssuesListView: View {
    @StateObject private var issuesVm = IssueViewModel()
    @State private var searchText = ""

    /// Filters issues by title or repository name based on the search text.
    private var filteredIssues: [Issue] {
        guard !searchText.isEmpty else { return issuesVm.issues }
        return issuesVm.issues.filter { issue in
            let titleMatch = issue.title?.localizedCaseInsensitiveContains(searchText) ?? false
            let repoMatch = issue.repository?.fullName.localizedCaseInsensitiveContains(searchText) ?? false
            return titleMatch || repoMatch
        }
    }

    var body: some View {
        ScrollView {
            if issuesVm.isIssuesLoading {
                ProgressView("Fetching Issues…")
                    .frame(maxWidth: .infinity, minHeight: 200)
            } else if let errorMessage = issuesVm.error {
                errorView(message: errorMessage)
            } else if filteredIssues.isEmpty {
                emptyView
            } else {
                LazyVStack(spacing: 8) {
                    ForEach(filteredIssues) { issue in
                        NavigationLink(destination: IssueDetailView(issue: issue)) {
                            IssueTileView(issue: issue)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Issues")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText, prompt: "Search your issues")
        .task {
            await issuesVm.fetchIssues()
        }
        .refreshable {
            await issuesVm.fetchIssues()
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
                Task { await issuesVm.fetchIssues() }
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 200)
    }

    // MARK: - Empty State

    private var emptyView: some View {
        VStack(spacing: 12) {
            Image(systemName: "tray")
                .font(.largeTitle)
                .foregroundStyle(.secondary)
            Text(searchText.isEmpty ? "No issues assigned to you" : "No issues matching \"\(searchText)\"")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, minHeight: 200)
    }
}

#Preview {
    NavigationStack {
        IssuesListView()
    }
}
