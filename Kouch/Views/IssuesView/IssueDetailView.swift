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
                            AssigneeStack(assignees: assignees) // Reusing the stack we built
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                if let labels = issue.labels, !labels.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(labels, id: \.id) { label in
                                CapsuleLabel(label: label) // Reusing the label view
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
                
                if (!(issuesVm.comments?.isEmpty ?? true)) {
                    Text("Comments")
                        .font(.headline)
                        .foregroundStyle(.primary)
                        .padding(.horizontal)
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(Array(issuesVm.comments ?? []), id: \.id) { comment in
                            IssueCommentsTile(comment: comment)
                        }
                    }.padding(.horizontal)
                }
                
            }
            .padding(.vertical)
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .toolbar {
            //            ToolbarItem(placement: .primaryAction) {
            //                Button { /* Action */ } label: {
            //                    Image(systemName: "sparkles")
            //                }
            //            }
            //            ToolbarSpacer(.fixed)
            ToolbarItem(placement: .primaryAction) {
                Button { /* Action */ } label: {
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
        .onAppear {
            refreshData()
        }
    }
    
    func refreshData() {
        issuesVm.fetchComments(repoName: issue.repository?.full_name, issueNumber: issue.number)
    }
}



#Preview {
    DashboardView()
}
