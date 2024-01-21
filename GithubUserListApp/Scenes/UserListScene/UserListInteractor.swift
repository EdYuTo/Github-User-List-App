//
//  UserListInteractor.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 20/01/24.
//

protocol UserListInteractorProtocol {
    func fetchList()
}

final class UserListInteractor {
    let provider: NertworkProviderProcotol
    let presenter: UserListPresenterProtocol
    let pageSize = 30
    var lastId: Int = 0
    var isLoading = false

    init(provider: NertworkProviderProcotol, presenter: UserListPresenterProtocol) {
        self.provider = provider
        self.presenter = presenter
    }
}

extension UserListInteractor: UserListInteractorProtocol {
    func fetchList() {
        guard !isLoading else { return }
        isLoading.toggle()
        let request = UserListRequest(lastId: lastId, pageSize: pageSize)
        provider.makeRequest(request) { [weak self] (result: Result<UserListResponse, Error>) in
            self?.isLoading.toggle()
            switch result {
            case let .success(response):
                self?.lastId = response.last?.id ?? 0
                self?.presenter.presentData(response)
            case .failure(_):
                self?.presenter.presentError()
            }
        }
    }
}
