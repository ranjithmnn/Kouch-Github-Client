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
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text(issue.repository?.full_name ?? "")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text("#\(issue.number ?? 0)")
                            .font(.caption)
                            .monospacedDigit()
                            .foregroundStyle(.tertiary)
                    }
                    
                    // Main Title
                    Text(issue.title ?? "No Title")
                        .font(.title2)
                        .fontWeight(.bold)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    // Status Badge & Metadata
                    HStack(spacing: 8) {
                        StatusBadge(state: issue.state ?? "open")
                        
                        Text("opened by **\(issue.user?.login ?? "ghost")**")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.horizontal)
                
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
                
            }
            .padding(.vertical)
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button { /* Action */ } label: {
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
    }
}

struct StatusBadge: View {
    let state: String
    var isOpen: Bool { state.lowercased() == "open" }
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: isOpen ? "circle.circle" : "checkmark.circle.fill")
            Text(state.capitalized)
        }
        .font(.caption)
        .fontWeight(.bold)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(isOpen ? Color.green.opacity(0.15) : Color.purple.opacity(0.15))
        .foregroundStyle(isOpen ? .green : .purple)
        .clipShape(Capsule())
    }
}

struct DetailStatView: View {
    let icon: String
    let value: String
    let label: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label).font(.caption2).foregroundStyle(.tertiary)
            Label(value, systemImage: icon)
                .font(.subheadline)
                .fontWeight(.medium)
        }
    }
}

#Preview {
    DashboardView()
}
