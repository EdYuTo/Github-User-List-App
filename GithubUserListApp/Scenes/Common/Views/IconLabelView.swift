//
//  IconLabelView.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 21/01/24.
//

import UIKit

final class IconLabelView: UIView {
    // MARK: - Views
    lazy var iconView: UIImageView = {
        let view = UIImageView()
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
    init() {
        super.init(frame: .zero)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    func setup(image: UIImage?) {
        iconView.image = image?.withRenderingMode(.alwaysTemplate)
    }
}

// MARK: - ViewCodeProtocol
extension IconLabelView: ViewCodeProtocol {
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
