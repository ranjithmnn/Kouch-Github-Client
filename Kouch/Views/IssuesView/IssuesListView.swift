//
//  IssuesListView.swift
//  Kouch
//
//  Created by Ranjith Menon on 06/04/2026.
//

import SwiftUI

struct IssuesListView: View {
    let issues: [Issue]
    var body: some View {
        ForEach(issues.indices, id: \.self) { index in
            IssueTileView(issue: issues[index])
        }
    }
}

struct IssueTileView: View {
    let issue: Issue
    var body: some View {
        HStack {
            VStack {
                Text(issue.title ?? "")
            }
        }
    }
}

#Preview {
    DashboardView()
}
