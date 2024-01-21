//
//  UserDetailsRouter.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 21/01/24.
//

import UIKit

protocol UserDetailsRouterProtocol {
    func openRepo(_ url: String)
}

final class UserDetailsRouter {
    weak var viewController: UserDetailsScreen?

    func setup(reposUrl: String) -> UIViewController {
        let provider = NertworkProvider()
        let presenter = UserDetailsPresenter()
        let interactor = UserDetailsInteractor(reposUrl: reposUrl, provider: provider, presenter: presenter)
        let viewController = UserDetailsScreen(interactor: interactor, router: self)
        presenter.displayer = viewController
        self.viewController = viewController
        return viewController
    }
}

extension UserDetailsRouter: UserDetailsRouterProtocol {
    func openRepo(_ url: String) {
        debugPrint(">>>>>", url)
    }
}
