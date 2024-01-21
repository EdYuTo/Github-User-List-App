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
    let userName: String
    let provider: NertworkProviderProcotol
    let presenter: UserDetailsPresenterProtocol
    let pageSize = 30
    var page = 1
    var isLoading = false

    init(userName: String, reposUrl: String, provider: NertworkProviderProcotol, presenter: UserDetailsPresenterProtocol) {
        self.userName = userName
        self.reposUrl = reposUrl
        self.provider = provider
        self.presenter = presenter
    }
}

extension UserDetailsInteractor: UserDetailsInteractorProtocol {
    func fetchUserDetails() {
        let userName = String(userName.dropFirst(1))
        let request = UserDetailsRequest(userName: userName)
        provider.makeRequest(request) { [weak self] (result: Result<UserDetailsResponse, Error>) in
            switch result {
            case .success(let success):
                self?.presenter.presentUserDetails(success)
            case .failure:
                self?.presenter.presentRepoListError()
            }
        }
    }

    func fetchRepoList() {
        let request = UserRepoListRequest(endpoint: reposUrl, nextPage: page, pageSize: pageSize)
        provider.makeRequest(request) { [weak self] (result: Result<UserRepoListResponse, Error>) in
            switch result {
            case .success(let success):
                self?.page += 1
                self?.presenter.presentRepoList(success)
            case .failure:
                self?.presenter.presentRepoListError()
            }
        }
    }
}
