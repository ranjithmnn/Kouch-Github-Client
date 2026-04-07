//
//  RepositoryList.swift
//  Kouch
//
//  Created by Ranjith Menon on 07/04/2026.
//

import SwiftUI

struct RepositoryList: View {
    @StateObject private var reposVm = RepositoriesViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            Group {
                if reposVm.isLoading {
                    ProgressView("Fetching Repos...")
                } else if let repos = reposVm.repo {
                    List(repos) { repo in
                        NavigationLink(destination: Text("Detail for \(repo.name ?? "")")) {
                            RepoRow(repo: repo)
                        }
                    }
                    .listStyle(.insetGrouped)
                } else if let error = reposVm.error {
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                        Text(error)
                    }
                }
            }
            .navigationTitle("Repositories")
            .searchable(text: $searchText, prompt: "Search your projects")
            .onAppear {
                reposVm.fetchUser()
            }
            .refreshable {
                // Native pull-to-refresh
                reposVm.fetchUser()
            }
        }
    }
}


struct RepoRow: View {
    let repo: Repository
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                // Repository Name
                Text(repo.name ?? "Unknown Repo")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Spacer()
                
                // Star Count (Minimal badge)
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("\(repo.stargazers_count ?? 0)")
                }
                .font(.caption2)
                .fontWeight(.bold)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color(.systemGray6))
                .clipShape(Capsule())
            }
            
            // Description (Optional)
            if let description = repo.description {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            
            // Metadata Footer
            HStack(spacing: 16) {
                if let language = repo.language {
                    HStack(spacing: 4) {
                        Circle()
                            .fill(Color.blue) // In a real app, map color to language
                            .frame(width: 8, height: 8)
                        Text(language)
                    }
                }
                
                if let owner = repo.owner {
                    Text("@\(owner.login)")
                        .italic()
                }
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    RepositoryList()
}
