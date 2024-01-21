//
//  UserDetailsInteractor.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 21/01/24.
//

protocol UserDetailsInteractorProtocol {
    func fetchUserDetails()
    func fetchRepoList()
}

final class UserDetailsInteractor {
    let reposUrl: String
    let provider: NertworkProviderProcotol
    let presenter: UserDetailsPresenterProtocol
    var page = 1
    var isLoading = false

    init(reposUrl: String, provider: NertworkProviderProcotol, presenter: UserDetailsPresenterProtocol) {
        self.reposUrl = reposUrl
        self.provider = provider
        self.presenter = presenter
    }
}

extension UserDetailsInteractor: UserDetailsInteractorProtocol {
    func fetchUserDetails() {
        presenter.presentUserDetails()
    }

    func fetchRepoList() {
        presenter.presentRepoList()
    }
}
