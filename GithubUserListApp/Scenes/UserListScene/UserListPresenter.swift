//
//  UserListPresenter.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 20/01/24.
//

import Foundation

protocol UserListPresenterProtocol {
    func presentData(_ response: UserListResponse)
}

final class UserListPresenter {
    weak var displayer: UserListDisplayProtocol?
}

extension UserListPresenter: UserListPresenterProtocol {
    func presentData(_ response: UserListResponse) {
        let data = response.map { userResponse in
            UserViewModel(
                userName: userResponse.login,
                avatarUrl: userResponse.avatarUrl,
                reposUrl: userResponse.reposUrl
            )
        }
        DispatchQueue.main.async { [weak self] in
            self?.displayer?.displayData(data)
        }
    }
}
