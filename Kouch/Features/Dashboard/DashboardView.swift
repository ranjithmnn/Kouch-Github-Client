//
//  DashboardView.swift
//  Kouch
//
//  Created by Ranjith Menon on 06/04/2026.
//

import SwiftUI

// MARK: - Dashboard Action

enum DashboardAction: String, Identifiable {
    case newIssue = "New Issue"
    case createPR = "Create Pull Request"
    case newRepo = "New Repository"

    var id: String { self.rawValue }
    var icon: String {
        switch self {
        case .newIssue: return "circle.circle"
        case .createPR: return "arrow.trianglehead.pull"
        case .newRepo: return "plus"
        }
    }
}

// MARK: - Dashboard View

struct DashboardView: View {
    @StateObject private var profileVm = ProfileViewModel()
    @StateObject private var issuesVm = IssueViewModel()
    @StateObject private var reposVm = RepositoriesViewModel()

    @State private var selectedAction: DashboardAction?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    headerSection
                    metricsGrid
                    recentIssuesSection
                    exploreSection
                }
                .padding(.vertical)
            }
            .background(Color(.systemGroupedBackground))
            .refreshable {
                await refreshData()
            }
            .task {
                await refreshData()
            }
            .sheet(item: $selectedAction) { action in
                ActionDetailSheet(actionName: action.rawValue)
            }
        }
    }

    private func refreshData() async {
        async let userFetch: () = profileVm.fetchUser()
        async let issuesFetch: () = issuesVm.fetchIssues()
        async let reposFetch: () = reposVm.fetchRepos()
        _ = await (userFetch, issuesFetch, reposFetch)
    }
}

// MARK: - Section Views

private extension DashboardView {

    var headerSection: some View {
        Group {
            if let user = profileVm.user {
                HStack(spacing: 16) {
                    GreetingsView(user: user)
                    Spacer()
                    MenuButtons(selectedAction: $selectedAction)
                    NavigationLink(destination: ProfileView(user: user)) {
                        UserAvatarView(url: user.avatarUrl)
                    }
                }
                .padding(.horizontal)
            } else if profileVm.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, minHeight: 60)
            }
        }
    }

    var metricsGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            MetricCard(title: "Assigned Issues", value: "\(issuesVm.issues.count)", icon: "at", color: .blue)
            MetricCard(title: "Open PRs", value: "0", icon: "arrow.triangle.pull", color: .purple)
        }
        .padding(.horizontal)
    }

    var recentIssuesSection: some View {
        Group {
            if !issuesVm.issues.isEmpty {
                VStack(alignment: .leading) {
                    SectionHeader(title: "Recent Issues", linkText: "See All") {
                        IssuesListView()
                    }

                    VStack(spacing: 0) {
                        ForEach(issuesVm.issues.prefix(3)) { issue in
                            NavigationLink(destination: IssueDetailView(issue: issue)) {
                                IssueTileView(issue: issue)
                            }
                            .buttonStyle(.plain)
                            if issue.id != issuesVm.issues.prefix(3).last?.id {
                                Divider().padding(.leading)
                            }
                        }
                    }
                    .modifier(RoundedContainerModifier())
                }
            } else if issuesVm.isIssuesLoading {
                ProgressView("Loading issues…")
                    .frame(maxWidth: .infinity, minHeight: 80)
            }
        }
    }

    var exploreSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Yours")
                .font(.headline)
                .padding(.leading)

            VStack(spacing: 0) {
                NavigationRow(title: "Repositories", icon: "folder", destination: RepositoryList())
                Divider().padding(.leading, 44)
                NavigationRow(title: "Projects", icon: "p.square", destination: Text("Projects"))
            }
            .modifier(RoundedContainerModifier())
        }
    }
}

// MARK: - Supporting Views

struct MenuButtons: View {
    @Binding var selectedAction: DashboardAction?

    var body: some View {
        Menu {
            MenuButton(action: .newIssue, selection: $selectedAction)
            MenuButton(action: .createPR, selection: $selectedAction)
            Divider()
            MenuButton(action: .newRepo, selection: $selectedAction)
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 16, weight: .bold))
                .frame(width: 44, height: 44)
                .background(Circle().fill(.ultraThinMaterial))
                .overlay(Circle().stroke(Color.primary.opacity(0.1), lineWidth: 0.5))
        }
    }
}

struct MenuButton: View {
    let action: DashboardAction
    @Binding var selection: DashboardAction?

    var body: some View {
        Button {
            selection = action
        } label: {
            Label(action.rawValue, systemImage: action.icon)
        }
    }
}

struct NavigationRow<Destination: View>: View {
    let title: String
    let icon: String
    let destination: Destination

    var body: some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundStyle(.blue)
                    .frame(width: 24)
                Text(title)
                    .foregroundStyle(.primary)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding()
        }
    }
}

struct SectionHeader<Destination: View>: View {
    let title: String
    let linkText: String
    let destination: () -> Destination

    var body: some View {
        HStack {
            Text(title).font(.headline)
            Spacer()
            NavigationLink(linkText, destination: destination)
                .font(.subheadline)
                .foregroundStyle(.blue)
        }
        .padding(.horizontal)
    }
}

struct UserAvatarView: View {
    let url: String?
    var size: CGFloat = 44

    var body: some View {
        AsyncImage(url: URL(string: url ?? "")) { img in
            img.resizable().aspectRatio(contentMode: .fill)
        } placeholder: {
            Circle().fill(.gray.opacity(0.3))
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
    }
}

struct ActionDetailSheet: View {
    let actionName: String
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                Text("Content for \(actionName)")
                    .font(.title3)
            }
            .navigationTitle(actionName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}

struct RoundedContainerModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal)
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
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    DashboardView()
}
