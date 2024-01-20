//
//  NertworkError.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 20/01/24.
//

enum NertworkError: Error {
    case unknown
    case emptyResponse
    case invalidUrl
    case invalidParams
    case decodingError(String)
}
