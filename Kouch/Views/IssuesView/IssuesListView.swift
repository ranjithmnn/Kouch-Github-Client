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
    let issues: [Issue]
    
    var body: some View {
        ScrollView {
            ForEach(Array(issues), id: \.number) { issue in
                NavigationLink(destination: IssueDetailView(issue: issue)) {
                    IssueTileView(issue: issue) // Your improved tile
                }
                .buttonStyle(.plain)
            }
        }
        .navigationTitle("Issues")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText, prompt: "Search your issues")
        .refreshable {
            issuesVm.fetchIssues()
        }
    }
}

#Preview {
    DashboardView()
}
