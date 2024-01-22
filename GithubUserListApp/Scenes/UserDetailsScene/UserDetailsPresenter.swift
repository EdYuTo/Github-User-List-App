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
        DispatchQueue.main.async { [weak self] in
            self?.displayer?.displayUserDetails(.success(viewModel))
        }
    }

    func presentUserDetailsLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.displayer?.displayUserDetails(.loading)
        }
    }

    func presentUserDetailsError() {
        DispatchQueue.main.async { [weak self] in
            self?.displayer?.displayUserDetails(.error)
        }
    }

    func presentRepoList(_ response: UserRepoListResponse) {
        var viewModel: [UserRepoViewModel] = response.compactMap { responseModel in
            guard !responseModel.fork else {
                return nil
            }
            return UserRepoViewModel.success(
                UserRepoSuccess(
                    name: responseModel.name,
                    description: responseModel.description ?? String(),
                    url: responseModel.cloneUrl,
                    stargazersCount: responseModel.stargazersCount,
                    language: responseModel.language ?? String()
                )
            )
        }
        viewModel.append(.loading)
        DispatchQueue.main.async { [weak self] in
            self?.displayer?.displayRepoList(viewModel)
        }
    }

    func presentRepoListError() {
        DispatchQueue.main.async { [weak self] in
            self?.displayer?.displayRepoList([.error])
        }
    }
}
