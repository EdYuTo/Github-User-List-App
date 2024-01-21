//
//  UserDetailsScreen.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 20/01/24.
//

import UIKit

protocol UserDetailsDisplayProtocol: AnyObject {
    func displayUserDetails()
    func displayRepoList()
}

final class UserDetailsScreen: UIViewController {
    // MARK: - Properties
    let interactor: UserDetailsInteractorProtocol
    let router: UserDetailsRouterProtocol

    // MARK: - Views

    // MARK: - Life cycle
    init(interactor: UserDetailsInteractorProtocol, router: UserDetailsRouterProtocol) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        interactor.fetchUserDetails()
        interactor.fetchRepoList()
    }
}

// MARK: - ViewCodeProtocol
extension UserDetailsScreen: ViewCodeProtocol {
    func setupHierarchy() {
        debugPrint(">>>>> Hierarchy")
    }

    func setupConstraints() {
        debugPrint(">>>>> Constraints")
    }
}

// MARK: - UserDetailsDisplayProtocol
extension UserDetailsScreen: UserDetailsDisplayProtocol {
    func displayUserDetails() {
        debugPrint(">>>>> User details!")
    }

    func displayRepoList() {
        debugPrint(">>>>> Repo list!")
    }
}
