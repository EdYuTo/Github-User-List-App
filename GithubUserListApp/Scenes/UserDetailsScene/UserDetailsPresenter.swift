//
//  UserDetailsPresenter.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 21/01/24.
//

import Foundation

protocol UserDetailsPresenterProtocol {
    func presentUserDetails()
    func presentRepoList()
}

final class UserDetailsPresenter {
    weak var displayer: UserDetailsDisplayProtocol?
}

extension UserDetailsPresenter: UserDetailsPresenterProtocol {
    func presentUserDetails() {
        displayer?.displayUserDetails()
    }

    func presentRepoList() {
        displayer?.displayRepoList()
    }
}
