//
//  UserDetailsResponse.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 21/01/24.
//

import Foundation

struct UserDetailsResponse: Decodable {
    let login: String
    let avatarUrl: String
    let name: String
    let followers: Int
    let following: Int
}
