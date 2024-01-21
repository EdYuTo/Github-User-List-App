//
//  UserTableViewCell.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 20/01/24.
//

import UIKit

final class UserTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let reuseIdentifier = String(describing: UserTableViewCell.self)
    let iconSize = Spacing.x64.value

    // MARK: - Views
    lazy var iconView: AsyncImageView = {
        let view = AsyncImageView(iconSize: CGSize(width: iconSize, height: iconSize))
        view.layer.cornerRadius = iconSize / 2
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var userName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()

    lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [iconView, userName])
        stack.axis = .horizontal
        stack.spacing = iconSize / 2
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    // MARK: - Life cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        iconView.startAnimating()
    }

    // MARK: Methods
    func setup(_ model: UserSuccess) {
        userName.text = model.userName
        setupView()
        iconView.startDownload(url: model.avatarUrl)
    }
}

// MARK: - ViewCodeProtocol
extension UserTableViewCell: ViewCodeProtocol {
    func setupHierarchy() {
        addSubview(mainStackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.x16.value),
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.x16.value),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.x16.value),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -Spacing.x16.value)
        ])
    }
}
