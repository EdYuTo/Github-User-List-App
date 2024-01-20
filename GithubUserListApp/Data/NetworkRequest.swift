//
//  NetworkRequest.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 20/01/24.
//

import Foundation

struct NetworkRequest {
    var endpoint: String
    var body: Data?
    var httpMethod: HTTPMethod? = .get
    var queryParams: [String: String]?
    var headers: [String: String]?
}
