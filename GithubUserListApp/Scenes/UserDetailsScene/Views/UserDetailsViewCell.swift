//
//  UserDetailsViewCell.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 21/01/24.
//

import UIKit

final class UserDetailsViewCell: UITableViewCell {
    // MARK: - Properties
    static let reuseIdentifier = String(describing: UserDetailsViewCell.self)
    let iconSize: CGFloat = Spacing.x128.value

    // MARK: - Views
    lazy var iconView: AsyncImageView = {
        let view = AsyncImageView(iconSize: CGSize(width: iconSize, height: iconSize))
        view.layer.cornerRadius = iconSize / 2
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var fullNameView: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var userNameView: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var followersView: FollowersView = {
        let view = FollowersView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconView, fullNameView, userNameView, followersView])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Spacing.x16.value
        stackView.setCustomSpacing(Spacing.x4.value, after: fullNameView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Life cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        iconView.startLoading()
    }

    // MARK: - Methods
    func setup(_ model: UserDetailsSuccess) {
        setupView()
        iconView.startDownload(url: model.avatarUrl)
        fullNameView.text = model.fullName
        userNameView.text = "@\(model.userName)"
        followersView.update(followersCount: model.followersCount, followingCount: model.followingCount)
    }
}

// MARK: - ViewCodeProtocol
extension UserDetailsViewCell: ViewCodeProtocol {
    func setupHierarchy() {
        addSubview(mainStackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
