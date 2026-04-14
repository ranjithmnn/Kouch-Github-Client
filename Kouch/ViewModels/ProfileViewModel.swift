//
//  DashboardViewModel.swift
//  Kouch
//
//  Created by Ranjith Menon on 06/04/2026.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoading = false
    @Published var error: String?
    
    private let userService = UserService()
    
    func fetchUser() {
        
//        if (user != nil) {
//            return
//        }
        
        isLoading = true
        userService.fetchUser { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let user):
                    self?.user = user
                    
                case .failure(let error):
                    self?.error = error.localizedDescription
                }
            }
        }
    }
}
