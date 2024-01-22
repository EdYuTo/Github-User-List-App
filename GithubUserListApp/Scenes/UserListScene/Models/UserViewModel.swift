//
//  UserViewModel.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 20/01/24.
//

enum UserViewModel {
    case success(UserSuccess)
    case loading
    case error
}

struct UserSuccess {
    let userName: String
    let avatarUrl: String
    let reposUrl: String
}
