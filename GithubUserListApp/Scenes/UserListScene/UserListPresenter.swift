//
//  UserListPresenter.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 20/01/24.
//

import Foundation

protocol UserListPresenterProtocol {
    func presentData(_ response: UserListResponse)
    func presentError()
}

final class UserListPresenter {
    weak var displayer: UserListDisplayProtocol?
}

extension UserListPresenter: UserListPresenterProtocol {
    func presentData(_ response: UserListResponse) {
        var data: [UserViewModel] = response.map { userResponse in
            UserViewModel.success(
                UserSuccess(
                    userName: "@\(userResponse.login)",
                    avatarUrl: userResponse.avatarUrl,
                    reposUrl: userResponse.reposUrl
                )
            )
        }
        data.append(UserViewModel.loading)
        DispatchQueue.main.async { [weak self] in
            self?.displayer?.displayData(data)
        }
    }

    func presentError() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.displayer?.displayError()
        }
    }
}
