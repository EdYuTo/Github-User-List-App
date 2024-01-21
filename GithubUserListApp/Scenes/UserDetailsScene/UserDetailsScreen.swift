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
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
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
        view.addSubview(collectionView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension UserDetailsScreen: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return detailsModel != nil ? 1 : 0
        case 1:
            return (detailsModel != nil ? 1 : 0) + repoList.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            return UICollectionViewCell()
        case 1:
            return UICollectionViewCell()
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - UserDetailsDisplayProtocol
extension UserDetailsScreen: UserDetailsDisplayProtocol {
    func displayUserDetails(_ details: UserDetailsViewModel) {
        detailsModel = details
        collectionView.reloadSections(.init(integer: 0))
    }

    func displayRepoList(_ repoList: UserRepoViewModel) {
        debugPrint(repoList)
    }
}
