//
//  UserListResponse.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 20/01/24.
//

import Foundation

typealias UserListResponse = [UserResponse]

struct UserResponse: Decodable {
    let id: Int
    let login: String
    let avatarUrl: String
    let reposUrl: String
}
