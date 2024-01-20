//
//  UserListScreen.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 20/01/24.
//

import UIKit

protocol UserListDisplayProtocol: AnyObject {
    func displayData(_ userList: [UserViewModel])
}

final class UserListScreen: UIViewController {
    // MARK: - Properties
    let interactor: UserListInteractorProtocol
    let router: UserListRouterProtocol
    var modelList = [UserViewModel]()

    // MARK: - Views
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.reuseIdentifier)
        tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: LoadingTableViewCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Life cycle
    init(interactor: UserListInteractorProtocol, router: UserListRouterProtocol) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        interactor.fetchList()
    }
}

// MARK: - ViewCodeProtocol
extension UserListScreen: ViewCodeProtocol {
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
extension UserListScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        modelList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < modelList.count {
            return loadUserCell(tableView, indexPath)
        } else {
            return loadLoadingCell(tableView, indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.row < modelList.count else { return }
        router.openDetails(modelList[indexPath.row].reposUrl)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYOffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYOffset
        
        if distanceFromBottom < height {
            interactor.fetchList()
        }
    }
    
    private func loadUserCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        guard let viewCell = tableView.dequeueReusableCell(
            withIdentifier: UserTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? UserTableViewCell else {
            return UITableViewCell()
        }
        viewCell.configure(modelList[indexPath.row])
        return viewCell
    }
    
    private func loadLoadingCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(
            withIdentifier: LoadingTableViewCell.reuseIdentifier,
            for: indexPath
        )
    }
}

// MARK: - UserListDisplayProtocol
extension UserListScreen: UserListDisplayProtocol {
    func displayData(_ userList: [UserViewModel]) {
        let size = modelList.count
        modelList.append(contentsOf: userList)
        if size == 0 {
            tableView.reloadData()
        } else {
            let loadingIndex = IndexPath(row: size, section: .zero)
            let newRows = (size+1...modelList.count).map { row in
                IndexPath(row: row, section: 0)
            }
            tableView.beginUpdates()
            tableView.reloadRows(at: [loadingIndex], with: .automatic)
            tableView.insertRows(at: newRows, with: .automatic)
            tableView.endUpdates()
        }
    }
}
