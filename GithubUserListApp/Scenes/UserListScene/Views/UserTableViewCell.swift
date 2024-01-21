//
//  UserTableViewCell.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 20/01/24.
//

import UIKit

final class UserTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let reuseIdentifier = "UserTableViewCell"
    let iconSize: CGFloat = 64

    // MARK: - Views
    lazy var avatar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        view.startAnimating()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var iconView: UIImageView = {
        let view = UIImageView()
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
        let stack = UIStackView(arrangedSubviews: [avatar, userName])
        stack.axis = .horizontal
        stack.spacing = iconSize / 2
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    // MARK: - Life cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        updateAvatar(with: loadingView)
        loadingView.startAnimating()
    }

    // MARK: Methods
    func setup(_ model: UserSuccess) {
        userName.text = model.userName
        setupView()
        ImageProvider.getImage(url: model.avatarUrl) { uiImage in
            DispatchQueue.main.async { [weak self] in
                self?.iconView.image = uiImage
                self?.updateAvatar(with: self?.iconView)
            }
        }
    }

    private func updateAvatar(with view: UIView?) {
        guard let view = view else { return }
        avatar.subviews.forEach { view in
            view.isHidden = true
        }
        UIView.transition(
            with: view, duration: 0.5,
            options: .transitionCrossDissolve,
            animations: {
                view.isHidden = false
            }
        )
        setNeedsLayout()
        layoutIfNeeded()
    }
}

// MARK: - ViewCodeProtocol
extension UserTableViewCell: ViewCodeProtocol {
    func setupHierarchy() {
        addSubview(mainStackView)
        avatar.addSubview(loadingView)
        avatar.addSubview(iconView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.x16.value),
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.x16.value),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.x16.value),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -Spacing.x16.value),

            avatar.widthAnchor.constraint(equalToConstant: iconSize),
            avatar.heightAnchor.constraint(equalTo: avatar.widthAnchor)
        ])

        avatar.subviews.forEach { view in
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalTo: avatar.widthAnchor),
                view.heightAnchor.constraint(equalTo: avatar.heightAnchor)
            ])
        }
    }
}
