//
//  IssuesViewModel.swift
//  Kouch
//
//  Created by Ranjith Menon on 06/04/2026.
//

import Foundation
import Combine

class IssueViewModel: ObservableObject {
    @Published var issues: [Issue]?
    @Published var isLoading = false
    @Published var error: String?
    
    private let issuesService = IssuesService()
    
    func fetchIssues() {
        
//        if (!(issues?.isEmpty ?? false)) {
//            return
//        }
        
        isLoading = true
        issuesService.fetchIssues { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let issues):
                    self?.issues = issues
                case .failure(let error):
                    self?.error = error.localizedDescription
                }
            }
        }
    }
}
