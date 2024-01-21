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
        let userName = userName.replacingOccurrences(of: "@", with: String())
        let request = UserDetailsRequest(userName: userName)
        provider.makeRequest(request) { (result: Result<UserDetailsResponse, Error>) in
            debugPrint(">>>>>", result)
        }
        presenter.presentUserDetails()
    }

    func fetchRepoList() {
        let request = UserRepoListRequest(endpoint: reposUrl)
        provider.makeRequest(request) { (result: Result<UserRepoListResponse, Error>) in
            debugPrint(">>>>>", result)
        }
        presenter.presentRepoList()
    }
}
