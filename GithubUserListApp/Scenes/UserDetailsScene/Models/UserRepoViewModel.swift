//
//  UserRepoViewModel.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 21/01/24.
//

enum UserRepoViewModel {
    case success([UserRepoSuccess])
    case loading
    case error
}

struct UserRepoSuccess: Decodable {
    let name: String
    let description: String
    let url: String
    let stargazersCount: Int
    let language: String
}
