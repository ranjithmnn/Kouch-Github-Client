//
//  IssueDetailView.swift
//  Kouch
//
//  Created by Ranjith Menon on 07/04/2026.
//

import SwiftUI

struct IssueDetailView: View {
    let issue: Issue
    @Environment(\.dismiss) var dismiss
    @StateObject private var issuesVm = IssueViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                IssueDetailsHeader(issue: issue)

                Divider().padding(.horizontal)

                HStack(spacing: 20) {
                    DetailStatView(icon: "bubble.left.and.bubble.right", value: "\(issue.comments ?? 0)", label: "Comments")

                    if let assignees = issue.assignees, !assignees.isEmpty {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Assignees").font(.caption2).foregroundStyle(.tertiary)
                            AssigneeStack(assignees: assignees)
                        }
                    }

                    Spacer()
                }
                .padding(.horizontal)

                if let labels = issue.labels, !labels.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(labels) { label in
                                CapsuleLabel(label: label)
                            }
                        }
                        .padding(.horizontal)
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("Description")
                        .font(.headline)
                        .foregroundStyle(.primary)

                    Text(issue.body ?? "No description provided.")
                        .font(.callout)
                        .lineSpacing(4)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal)

                // Comments Section
                if issuesVm.isCommentsLoading {
                    ProgressView("Loading comments…")
                        .frame(maxWidth: .infinity, minHeight: 60)
                } else if !issuesVm.comments.isEmpty {
                    Text("Comments")
                        .font(.headline)
                        .foregroundStyle(.primary)
                        .padding(.horizontal)
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(issuesVm.comments) { comment in
                            IssueCommentsTile(comment: comment)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                if let url = issueURL {
                    ShareLink(item: url) {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
        }
        .task {
            await issuesVm.fetchComments(
                repoName: issue.repository?.fullName,
                issueNumber: issue.number
            )
        }
    }

    /// Constructs a web URL for this issue.
    private var issueURL: URL? {
        guard let fullName = issue.repository?.fullName else { return nil }
        return URL(string: "https://github.com/\(fullName)/issues/\(issue.number)")
    }
}

#Preview {
    NavigationStack {
        IssueDetailView(
            issue: Issue(
                id: 1,
                user: nil,
                title: "Sample Issue",
                number: 42,
                labels: nil,
                state: "open",
                locked: false,
                comments: 3,
                createdAt: nil,
                updatedAt: nil,
                closedAt: nil,
                assignees: nil,
                repository: nil,
                body: "This is a sample issue body for preview."
            )
        )
    }
}
