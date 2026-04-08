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
            } else if let repos = reposVm.repos {
                ForEach(Array(repos), id: \.full_name) { repo in
                    NavigationLink(destination: Text("Detail for \(repo.name ?? "")")) {
                        RepoTileView(repo: repo)
                    }.buttonStyle(.plain)
                }
                
            } else if let error = reposVm.error {
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                    Text(error)
                }
            }
            
        }
        .navigationTitle("Repositories")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText, prompt: "Search your repositories")
        .onAppear {
            reposVm.fetchUser()
        }
        .refreshable {
            reposVm.fetchUser()
        }
    }
}


#Preview {
    NavigationStack {
        RepositoryList()
    }
}
