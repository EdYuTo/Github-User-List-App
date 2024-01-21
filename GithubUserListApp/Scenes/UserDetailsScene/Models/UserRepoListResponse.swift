//
//  UserRepoListResponse.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 21/01/24.
//

import Foundation

struct UserRepoResponse: Decodable {
    let name: String
    let description: String?
    let cloneUrl: String
    let stargazersCount: Int
    let language: String?
}

typealias UserRepoListResponse = [UserRepoResponse]
