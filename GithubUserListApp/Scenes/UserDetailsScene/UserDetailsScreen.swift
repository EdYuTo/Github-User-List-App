//
//  UserDetailsScreen.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 20/01/24.
//

import UIKit

protocol UserDetailsDisplayProtocol: AnyObject {
    func displayUserDetails(_ details: UserDetailsViewModel)
    func displayRepoList(_ repoList: UserRepoViewModel)
}

final class UserDetailsScreen: UIViewController {
    // MARK: - Properties
    let interactor: UserDetailsInteractorProtocol
    let router: UserDetailsRouterProtocol
    var detailsModel: UserDetailsViewModel?
    var repoModel: UserRepoViewModel?
    var repoList = [UserRepoSuccess]()

    // MARK: - Views
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UserDetailsViewCell.self, forCellReuseIdentifier: UserDetailsViewCell.reuseIdentifier)
        tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: LoadingTableViewCell.reuseIdentifier)
        tableView.register(ErrorTableViewCell.self, forCellReuseIdentifier: ErrorTableViewCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

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
        view.addSubview(tableView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension UserDetailsScreen: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return detailsModel != nil ? 1 : 0
        case 1:
            return repoList.count + (repoModel != nil ? 1 : 0)
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return loadUserDetails(tableView, indexPath)
        case 1:
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0, case .error = detailsModel {
            interactor.fetchUserDetails()
        }
    }

    private func loadUserDetails(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        switch detailsModel {
        case let .success(details):
            let userCell = tableView.dequeueReusableCell(withIdentifier: UserDetailsViewCell.reuseIdentifier, for: indexPath) as? UserDetailsViewCell
            userCell?.setup(details)
            userCell?.selectionStyle = .none
            cell = userCell
        case .loading:
            let loadingCell = tableView.dequeueReusableCell(
                withIdentifier: LoadingTableViewCell.reuseIdentifier,
                for: indexPath
            ) as? LoadingTableViewCell
            loadingCell?.setup()
            loadingCell?.selectionStyle = .none
            cell = loadingCell
        case .error:
            let errorCell = tableView.dequeueReusableCell(
                withIdentifier: ErrorTableViewCell.reuseIdentifier,
                for: indexPath
            ) as? ErrorTableViewCell
            errorCell?.setup()
            cell = errorCell
        default:
            break
        }
        return cell ?? UITableViewCell()
    }
}

// MARK: - UserDetailsDisplayProtocol
extension UserDetailsScreen: UserDetailsDisplayProtocol {
    func displayUserDetails(_ details: UserDetailsViewModel) {
        detailsModel = details
        tableView.reloadSections(.init(integer: 0), with: .fade)
    }

    func displayRepoList(_ repoList: UserRepoViewModel) {
        debugPrint(repoList)
    }
}
