//
//  ProfileViewModel.swift
//  Kouch
//
//  Created by Ranjith Menon on 06/04/2026.
//

import Foundation
import Combine

/// ViewModel for managing user profile data.
class ProfileViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoading = false
    @Published var error: String?

    private let userService: UserServiceProtocol

    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }

    func fetchUser() async {
        isLoading = true
        error = nil
        do {
            let fetchedUser = try await userService.fetchUser()
            user = fetchedUser
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
}
