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
            ScrollView {
                VStack(spacing: 24) {
                    // 1. Header Section
                    if let user = profileVm.user {
                        HStack {
                            GreetingsView(user: user)
                            Spacer()
                            Menu {
                                Button {
                                } label: {
                                    Label("New Issue", systemImage: "circle.circle")
                                }
                                Button {
                                } label: {
                                    Label("Create Pull Request", systemImage: "arrow.trianglehead.pull")
                                }
                                Divider()
                                Button {
                                } label: {
                                    Label("New Repository", systemImage: "plus")
                                }
                            } label: {
                                Image(systemName: "plus")
                            }
                            .buttonBorderShape(.circle)
                            .buttonStyle(.glass)
                            
                            
                            NavigationLink {
                                ProfileView(user: profileVm.user ?? User())
                            } label: {
                                AsyncImage(url: URL(string: user.avatar_url ?? "")) { img in
                                    img.resizable().aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    Circle().fill(.gray.opacity(0.3))
                                }
                                .frame(width: 44, height: 44)
                                .clipShape(Circle())
                                .padding(.trailing)
                            }
                            
                        }
                    }
                    
                    // 2. Metrics Grid (Info Rich)
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        MetricCard(title: "Assigned Issues", value: "\(issuesVm.issues?.count ?? 0)", icon: "at", color: .blue)
                        MetricCard(title: "Open PRs", value: "0", icon: "arrow.triangle.pull", color: .purple) // Placeholder for now
                    }
                    .padding(.horizontal)
                    
                    // 3. Recent Issues Section (Minimal)
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Recent Issues")
                                .font(.headline)
                            Spacer()
                            NavigationLink("See All") {
                                IssuesListView(issues: issuesVm.issues ?? []) // Dedicated View
                            }
                            .font(.subheadline)
                            .foregroundStyle(.blue)
                        }
                        .padding(.horizontal)
                        
                        VStack(spacing: 0) {
                            if let issues = issuesVm.issues?.prefix(3) {
                                ForEach(Array(issues), id: \.number) { issue in
                                    NavigationLink(destination: IssueDetailView(issue: issue)) {
                                        IssueTileView(issue: issue) // Your improved tile
                                    }
                                    .buttonStyle(.plain)
                                    Divider().padding(.leading)
                                }
                            } else {
                                ContentUnavailableView("No Issues", systemImage: "circle.circle")
                            }
                        }
                        .background(Color(.secondarySystemGroupedBackground))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                    
                    // 4. Quick Links / Categories
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Explore")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        NavigationLink(destination: RepositoryList()) {
                            Label("Repositories", systemImage: "folder")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(Color(.secondarySystemGroupedBackground))
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .refreshable {
                profileVm.fetchUser()
                issuesVm.fetchIssues()
            }
            .onAppear {
                profileVm.fetchUser()
                issuesVm.fetchIssues()
            }
        }
    }
}

struct MetricCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(color)
                    .font(.headline)
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(value)
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.bold)
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}


#Preview {
    DashboardView()
}
