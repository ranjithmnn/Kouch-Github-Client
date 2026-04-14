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
    @Published var isIssuesLoading = false
    @Published var comments: [Comment]?
    @Published var isCommentsLoading = false
    @Published var error: String?
    
    private let issuesService = IssuesService()
    
    func fetchIssues() {
        isIssuesLoading = true
        issuesService.fetchIssues { [weak self] result in
            DispatchQueue.main.async {
                self?.isIssuesLoading = false
                
                switch result {
                case .success(let issues):
                    self?.issues = issues
                case .failure(let error):
                    self?.error = error.localizedDescription
                }
            }
        }
    }
    
    func fetchComments(repoName: String?, issueNumber: Int?) {
        isCommentsLoading = true
        issuesService.fetchIssueComments(repoName: repoName, issueNumber: issueNumber) { [weak self] result in
            DispatchQueue.main.async {
                self?.isIssuesLoading = false
                
                switch result {
                case .success(let comments):
                    self?.comments = comments
                case .failure(let error):
                    self?.error = error.localizedDescription
                }
            }
        }
    }
}
