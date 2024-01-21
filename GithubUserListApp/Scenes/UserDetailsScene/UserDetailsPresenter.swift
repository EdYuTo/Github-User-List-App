//
//  UserDetailsPresenter.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 21/01/24.
//

import Foundation

protocol UserDetailsPresenterProtocol {
    func presentUserDetails(_ response: UserDetailsResponse)
    func presentUserDetailsLoading()
    func presentUserDetailsError()
    func presentRepoList(_ response: UserRepoListResponse)
    func presentRepoListLoading()
    func presentRepoListError()
}

final class UserDetailsPresenter {
    weak var displayer: UserDetailsDisplayProtocol?
}

extension UserDetailsPresenter: UserDetailsPresenterProtocol {
    func presentUserDetails(_ response: UserDetailsResponse) {
        let viewModel = UserDetailsSuccess(
            userName: response.login,
            avatarUrl: response.avatarUrl,
            fullName: response.name,
            followersCount: response.followers,
            followingCount: response.following
        )
        displayer?.displayUserDetails(.success(viewModel))
    }

    func presentUserDetailsLoading() {
        displayer?.displayUserDetails(.loading)
    }

    func presentUserDetailsError() {
        displayer?.displayUserDetails(.error)
    }

    func presentRepoList(_ response: UserRepoListResponse) {
        let viewModel: [UserRepoSuccess] = response.compactMap { responseModel in
            guard !responseModel.fork else {
                return nil
            }
            return UserRepoSuccess(
                name: responseModel.name,
                description: responseModel.description ?? String(),
                cloneUrl: responseModel.cloneUrl,
                stargazersCount: responseModel.stargazersCount,
                language: responseModel.language ?? String()
            )
        }
        displayer?.displayRepoList(.success(viewModel))
    }

    func presentRepoListLoading() {
        displayer?.displayRepoList(.loading)
    }

    func presentRepoListError() {
        displayer?.displayRepoList(.error)
    }
}
