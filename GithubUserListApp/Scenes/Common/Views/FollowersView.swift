//
//  FollowersView.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 21/01/24.
//

import UIKit

final class FollowersView: UIView {
    // MARK: - Properties
    var followersCount: Int
    var followingCount: Int

    // MARK: - Views
    lazy var iconView: UIView = {
        let image = Image.person.value?.withRenderingMode(.alwaysTemplate)
        let view = UIImageView(image: image)
        if traitCollection.userInterfaceStyle == .light {
            view.tintColor = .black
        } else {
            view.tintColor = .white
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var labelView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconView, labelView])
        stackView.spacing = Spacing.x8.value
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Life cycle
    init(followersCount: Int = 0, followingCount: Int = 0) {
        self.followersCount = followersCount
        self.followingCount = followingCount
        super.init(frame: .zero)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    func update(followersCount: Int = 0, followingCount: Int = 0) {
        self.followersCount = followersCount
        self.followingCount = followingCount
        setupConfigurations()
    }
}

// MARK: - ViewCodeProtocol
extension FollowersView: ViewCodeProtocol {
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

    func setupConfigurations() {
        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(string: "\(followersCount) ", attributes: [
            .font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        ]))
        attributedText.append(NSAttributedString(string: "followers - ", attributes: [
            .font: UIFont.systemFont(ofSize: UIFont.systemFontSize)
        ]))
        attributedText.append(NSAttributedString(string: "\(followingCount) ", attributes: [
            .font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        ]))
        attributedText.append(NSAttributedString(string: "following", attributes: [
            .font: UIFont.systemFont(ofSize: UIFont.systemFontSize)
        ]))
        labelView.attributedText = attributedText
    }
}
