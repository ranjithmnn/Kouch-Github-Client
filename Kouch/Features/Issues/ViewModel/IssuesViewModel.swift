//
//  IssuesViewModel.swift
//  Kouch
//
//  Created by Ranjith Menon on 06/04/2026.
//

import Foundation
import Combine

/// ViewModel for managing issue data and issue comments.
class IssueViewModel: ObservableObject {
    @Published var issues: [Issue] = []
    @Published var isIssuesLoading = false
    @Published var comments: [Comment] = []
    @Published var isCommentsLoading = false
    @Published var error: String?

    private let issuesService: IssuesServiceProtocol

    init(issuesService: IssuesServiceProtocol = IssuesService()) {
        self.issuesService = issuesService
    }

    func fetchIssues() async {
        isIssuesLoading = true
        error = nil
        do {
            let fetchedIssues = try await issuesService.fetchIssues()
            issues = fetchedIssues
        } catch {
            self.error = error.localizedDescription
        }
        isIssuesLoading = false
    }

    func fetchComments(repoName: String?, issueNumber: Int?) async {
        guard let repoName, let issueNumber else {
            error = "Missing repository name or issue number."
            return
        }
        isCommentsLoading = true
        error = nil
        do {
            let fetchedComments = try await issuesService.fetchIssueComments(
                repoName: repoName,
                issueNumber: issueNumber
            )
            comments = fetchedComments
        } catch {
            self.error = error.localizedDescription
        }
        isCommentsLoading = false
    }
}
