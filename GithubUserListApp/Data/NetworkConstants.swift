//
//  NetworkConstants.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 20/01/24.
//

enum NetworkConstants {
    enum Endpoint {
            static let users = "https://api.github.com/users"
    }

    enum Header {
        static let accept = "Accept"
        static let gitApiVersion = "X-GitHub-Api-Version"
    }
}
