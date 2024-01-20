//
//  UserListRequest.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 20/01/24.
//

import Foundation

struct UserListRequest: NetworkRequest {
    var lastId: Int
    var pageSize: Int

    var endpoint: String {
        "https://api.github.com/users"
    }

    var queryParams: [String: String]? {
        [
            "since": "\(lastId)",
            "per_page": "\(pageSize)"
        ]
    }

    var headers: [String: String]? {
        [
            "User-Agent": "insomnia/8.6.0",
            "Accept": "application/vnd.github+json",
            "X-GitHub-Api-Version": "2022-11-28"
        ]
    }

    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
