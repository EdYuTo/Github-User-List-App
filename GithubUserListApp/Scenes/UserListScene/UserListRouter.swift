//
//  UserListRouter.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 20/01/24.
//

import UIKit

protocol UserListRouterProtocol: AnyObject {
    func openDetails(_ repoUrl: String)
}

final class UserListRouter {
    weak var viewController: UserListScreen?

    func setup() -> UIViewController {
        let provider = NertworkProvider()
        let presenter = UserListPresenter()
        let interactor = UserListInteractor(provider: provider, presenter: presenter)
        let viewController = UserListScreen(interactor: interactor, router: self)
        presenter.displayer = viewController
        self.viewController = viewController
        return viewController
    }
}

extension UserListRouter: UserListRouterProtocol {
    func openDetails(_ repoUrl: String) {
        debugPrint(repoUrl)
        let userDetails = UserDetailsScreen()
        viewController?.navigationController?.pushViewController(userDetails, animated: true)
    }
}
