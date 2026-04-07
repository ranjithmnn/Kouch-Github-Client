//
//  RepositoriesViewModel.swift
//  Kouch
//
//  Created by Ranjith Menon on 07/04/2026.
//

import Foundation
import Combine

class RepositoriesViewModel: ObservableObject {
    @Published var repo: [Repository]?
    @Published var isLoading = false
    @Published var error: String?
    
    private let repoService = ReposService()
    
    func fetchUser() {
        
        if (repo != nil) {
            return
        }
        
        isLoading = true
        repoService.fetchRepos { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let repo):
                    self?.repo = repo
                    
                case .failure(let error):
                    self?.error = error.localizedDescription
                }
            }
        }
    }
}
