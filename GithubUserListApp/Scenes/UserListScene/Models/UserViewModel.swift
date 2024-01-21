//
//  UserViewModel.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 20/01/24.
//

enum UserViewModel: Equatable {
    case success(UserSuccess)
    case loading
    case error
    
    static func == (lhs: UserViewModel, rhs: UserViewModel) -> Bool {
        switch (lhs, rhs) {
        case (.success, .success),
            (.loading, .loading),
            (.error, .error):
            return true
        default:
            return false
        }
    }
}

struct UserSuccess {
    let userName: String
    let avatarUrl: String
    let reposUrl: String
}
