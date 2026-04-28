//
//  IssueDetailsHeader.swift
//  Kouch
//
//  Created by Ranjith Menon on 14/04/2026.
//

import SwiftUI

struct IssueDetailsHeader: View {
    let issue: Issue

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(issue.repository?.fullName ?? "")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.secondary)
                Spacer()
                Text("#\(issue.number)")
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
    }
}