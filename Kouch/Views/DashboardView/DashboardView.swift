//
//  DashboardView.swift
//  Kouch
//
//  Created by Ranjith Menon on 06/04/2026.
//

import SwiftUI

struct DashboardView: View {
    @StateObject private var profileVm = ProfileViewModel()
    @StateObject private var issuesVm = IssueViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                if let user = profileVm.user {
                    GreetingsView(user: user)
                }
                if let issues = issuesVm.issues {
                    IssuesListView(issues: issues)
                }
                Spacer()
            }
            .onAppear {
                profileVm.fetchUser()
                issuesVm.fetchIssues()
            }
        }
    }
}



#Preview {
    DashboardView()
}
