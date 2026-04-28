//
//  RepositoriesViewModel.swift
//  Kouch
//
//  Created by Ranjith Menon on 07/04/2026.
//

import Foundation
import Combine

/// ViewModel for managing repository list data.
class RepositoriesViewModel: ObservableObject {
    @Published var repos: [Repository] = []
    @Published var isLoading = false
    @Published var error: String?

    private let repoService: ReposServiceProtocol

    init(repoService: ReposServiceProtocol = ReposService()) {
        self.repoService = repoService
    }

    func fetchRepos() async {
        isLoading = true
        error = nil
        do {
            let fetchedRepos = try await repoService.fetchRepos()
            repos = fetchedRepos
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
}
