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
    
    var body: some View {
        ScrollView {
            if issuesVm.isLoading {
                ProgressView("Fetching Issues...")
            } else {
                ForEach(issuesVm.issues ?? [], id: \.number) { issue in
                    NavigationLink(destination: IssueDetailView(issue: issue)) {
                        IssueTileView(issue: issue) // Your improved tile
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .navigationTitle("Issues")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText, prompt: "Search your issues")
        .onAppear {
            issuesVm.fetchIssues()
        }
        .refreshable {
            issuesVm.fetchIssues()
        }
    }
}

#Preview {
    DashboardView()
}
