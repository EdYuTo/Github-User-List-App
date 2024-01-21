//
//  UserDetailsViewModel.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 21/01/24.
//

enum UserDetailsViewModel {
    case success(UserDetailsSuccess)
    case loading
    case error
}

struct UserDetailsSuccess: Decodable {
    let userName: String
    let avatarUrl: String
    let fullName: String
    let followersCount: Int
    let followingCount: Int
}
