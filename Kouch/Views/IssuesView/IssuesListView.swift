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
    }
}

#Preview {
    DashboardView()
}
