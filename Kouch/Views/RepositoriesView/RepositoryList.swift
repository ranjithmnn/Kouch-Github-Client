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
        ScrollView {
            if reposVm.isLoading {
                ProgressView("Fetching Repos...")
            } else {
                ForEach(reposVm.repos ?? [], id: \.full_name) { repo in
                    NavigationLink(destination: Text("Detail for \(repo.name ?? "")")) {
                        RepoTileView(repo: repo)
                    }.buttonStyle(.plain)
                }
            }
        }
        .navigationTitle("Repositories")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText, prompt: "Search your repositories")
        .onAppear {
            reposVm.fetchRepos()
        }
        .refreshable {
            reposVm.fetchRepos()
        }
    }
}


#Preview {
    NavigationStack {
        RepositoryList()
    }
}
