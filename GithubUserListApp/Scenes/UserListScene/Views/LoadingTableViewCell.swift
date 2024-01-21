//
//  LoadingTableViewCell.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 20/01/24.
//

import UIKit

final class LoadingTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let reuseIdentifier = String(describing: LoadingTableViewCell.self)

    // MARK: - Views
    lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        view.startAnimating()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Life cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        loadingView.startAnimating()
    }

    // MARK: - Methods
    func setup() {
        setupView()
    }
}

// MARK: - ViewCodeProtocol
extension LoadingTableViewCell: ViewCodeProtocol {
    func setupHierarchy() {
        addSubview(loadingView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
